if exists("g:ConcealImproved")
    finish
endif
let g:ConcealImproved = 1

function! ConcealImproved#skip_conceal()
	if !exists('w:last_col') | let w:last_col = 0 | endif
	let l:cur_col = col('.')
    let l:cur_line = line('.')
	if synconcealed(l:cur_line, l:cur_col)[0]
		let l:right = l:cur_col > w:last_col
		let l:start = l:cur_col + (l:right ? 1 : -1)
		let l:end = l:right ? col('$') : 0
		for l:i in range(l:start, l:end, l:right ? 1 : -1)
			if !synconcealed(l:cur_line, l:i)[0]
				call setpos('.', [0,l:cur_line,l:i,0])
                let l:found = 1
				break
			endif
		endfor
        if !exists("l:found")
            call setpos('.', [0,l:cur_line,right ? col('$') : 0,0])
        endif
	endif
    let w:last_col = col('.')
endfun

function! ConcealImproved#reveal_near_cursor()
    let l:line = line('.')
    let l:col = col('.')
	let l:should_conceal = 1
	for dx in range(0, 2)
		if synconcealed(l:line, l:col+dx)[0]
			let l:should_conceal = 0
			set concealcursor=
			break
        endif
    endfor
    if l:should_conceal
        set concealcursor=ni
	endif
endfun

if !(has('g:custom_ConcealImproved') && g:custom_ConcealImproved)
    autocmd CursorMoved * call ConcealImproved#skip_conceal()
    autocmd CursorMovedI * call ConcealImproved#reveal_near_cursor()
    autocmd InsertLeave * set concealcursor=ni
endif
