let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'colorscheme',
      \ }

function! s:unite_source.gather_candidates(args, context)
  " [(name, dir)]
  " e.g. [('adaryn', '/Users/ujihisa/.vimbundles/ColorSamplerPack/colors'), ...]
  let colorlist = map(split(globpath(&runtimepath, 'colors/*.vim'), '\n'),
      \'[fnamemodify(v:val, ":t:r"), fnamemodify(v:val, ":h")]')

  return map(colorlist, '{
        \ "word": v:val[0],
        \ "source": "colorscheme",
        \ "kind": "command",
        \ "action__command": "colorscheme " . v:val[0],
        \ }')
endfunction

function! unite#sources#colorscheme#define()
  return s:unite_source
endfunction


"unlet s:unite_source

let &cpo = s:save_cpo
unlet s:save_cpo
