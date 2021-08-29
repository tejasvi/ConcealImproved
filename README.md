<img src="logo.svg" width=100%>

Improvements over default conceal:

1. Skip over concealed text during cursor movement. (default: normal mode)
2. Autoreveal concealed characters near cursor. (default: insert mode)

---

The following default autocommands can be disabled with `let g:custom_betterconcealed=1`:

```
autocmd CursorMoved * call ConcealImproved#skip_conceal()
autocmd CursorMovedI * call ConcealImproved#reveal_near_cursor()
autocmd InsertLeave * set concealcursor=ni
```

Relevant configuration:

```
set concealcursor=ni
set conceallevel=2
nnoremap <silent>co :set <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=2'<CR><CR>
```
