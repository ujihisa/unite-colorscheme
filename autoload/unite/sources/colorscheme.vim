let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'colorscheme',
      \ 'hooks': {},
      \ 'action_table': {'*': {}},
      \ }

function! s:unite_source.hooks.on_init(args, context)
  if exists('g:colors_name')
    let s:beforecolor = g:colors_name
  else
    let s:beforecolor = "default"
  endif
endfunction

function! s:unite_source.hooks.on_close(args, context)
  if s:beforecolor == g:colors_name
    return
  endif
  execute s:colorscheme(s:beforecolor)
endfunction

let s:unite_source.action_table['*'].preview = {
      \ 'description' : 'preview this colorscheme',
      \ 'is_quit' : 0,
      \ }

function! s:unite_source.action_table['*'].preview.func(candidate)
  execute a:candidate.action__command
endfunction

function! s:lookup(varname, default)
  return exists(a:varname) ? eval(a:varname) : a:default
endfunction

function! s:colorscheme(x)
  return printf("%s %s",
        \ s:lookup("g:unite_colorscheme_command", "colorscheme"),
        \ a:x)
endfunction

function! s:unite_source.gather_candidates(args, context)
  " [(name, path)]
  " e.g. [('adaryn', '/Users/ujihisa/.vimbundles/ColorSamplerPack/colors/adaryn.vim'), ...]
  let colorlist = map(split(globpath(&runtimepath, 'colors/*.vim'), '\n'),
      \'[fnamemodify(v:val, ":t:r"), fnamemodify(v:val, ":p")]')

  " "action__type" is needed to avoid being added to the history.
  return map(colorlist, '{
        \ "word": v:val[0],
        \ "source": "colorscheme",
        \ "kind": ["file", "command"],
        \ "action__command": s:colorscheme(v:val[0]),
        \ "action__type": ": ",
        \ "action__path": v:val[1],
        \ }')
endfunction

function! unite#sources#colorscheme#define()
  return s:unite_source
endfunction


"unlet s:unite_source

let &cpo = s:save_cpo
unlet s:save_cpo
