let s:save_cpo = &cpo
set cpo&vim

let s:kind = {
      \ 'name': 'colorscheme',
      \ 'default_action': 'execute',
      \ 'action_table': {},
      \ }
let s:kind.action_table.execute = {}
function! s:kind.action_table.execute.func(candidate)
  execute "colorscheme" a:candidate.word
endfunction

function! unite#kinds#colorscheme#define()
  return s:kind
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
