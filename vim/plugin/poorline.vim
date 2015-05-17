if exists('g:loaded_poorline') && g:loaded_poorline
    finish
endif
let g:loaded_poorline = 1


" Status line

let s:last_status_mode = ''
let s:last_status_mode_ret = ''

function! poorline#stl_mode()
    let l:status_mode = mode()

    if l:status_mode != s:last_status_mode
        if l:status_mode == 'n'
            highlight PoorlineModeHL ctermbg=4 ctermfg=16
            let s:last_status_mode_ret = 'N'
        elseif l:status_mode == 'v' || l:status_mode == 'V' || l:status_mode == ''
            highlight PoorlineModeHL ctermbg=3 ctermfg=16
            let s:last_status_mode_ret = 'V'
        elseif l:status_mode == 's' || l:status_mode == 'S' || l:status_mode == ''
            highlight PoorlineModeHL ctermbg=5 ctermfg=16
            let s:last_status_mode_ret = 'S'
        elseif l:status_mode == 'i'
            highlight PoorlineModeHL ctermbg=2 ctermfg=16
            let s:last_status_mode_ret = 'I'
        elseif l:status_mode == 'R'
            highlight PoorlineModeHL ctermbg=1 ctermfg=16
            let s:last_status_mode_ret = 'R'
        elseif l:status_mode == 'Rv'
            highlight PoorlineModeHL ctermbg=1 ctermfg=16
            let s:last_status_mode_ret = 'v'
        else
            highlight PoorlineModeHL ctermbg=4 ctermfg=16
            let s:last_status_mode_ret = l:status_mode
        endif
        let s:last_status_mode = l:status_mode
    endif

    return s:last_status_mode_ret
endfunction


function! s:poorline_statusline()
    if has('statusline')
        let &statusline = ''
        let &statusline .= ' - '
        let &statusline .= ' %n '                            " buffer.
        let &statusline .= ' %{&fenc != "" ? &fenc : &enc} ' " encoding.
        let &statusline .= ' %{&ff} '                        " format.
        let &statusline .= ' %t '                            " filename.
        let &statusline .= '%{&modified != "" ? "±" : " "} ' " modified.
        let &statusline .= '%r '                             " read-only.
        let &statusline .= '%='                              " right-align.
        let &statusline .= ' %Y '                            " file type.
        let &statusline .= ' R%5l '                          " row.
        let &statusline .= ' C%5v '                          " col.
        let &statusline .= ' %3p%% '                         " scroll %.

        let s:stl_active = ''
        let s:stl_active .= '%#PoorlineModeHL# %{poorline#stl_mode()} '  " mode.
        let s:stl_active .= '%4* %n '                              " buffer.
        let s:stl_active .= '%3* %{&fenc != "" ? &fenc : &enc} '   " encoding.
        let s:stl_active .= '%2* %{&ff} '                          " format.
        let s:stl_active .= '%1* %t '                              " file name.
        let s:stl_active .= '%{&modified != "" ? "±" : " "} '      " modified.
        let s:stl_active .= '%r '                                  " read-only.
        let s:stl_active .= '%='                                   " right align.
        let s:stl_active .= ' %Y '                                 " file type.
        let s:stl_active .= '%2* R%5l '                            " row.
        let s:stl_active .= '%3* C%5v '                            " col.
        let s:stl_active .= '%4* %3p%% '                           " scroll %.

        highlight User1 ctermbg=235 ctermfg=231
        highlight User2 ctermbg=248 ctermfg=16
        highlight User3 ctermbg=250 ctermfg=16
        highlight User4 ctermbg=252 ctermfg=16
        highlight PoorlineModeHL ctermbg=4 ctermfg=16

        augroup Poorline
            au!
            au VimEnter,WinEnter,BufWinEnter * let &l:statusline = s:stl_active
            au WinLeave,BufWinLeave * let &l:statusline = ''
        augroup END
    endif
endfunction

call s:poorline_statusline()
