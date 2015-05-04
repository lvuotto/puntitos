if exists('g:loaded_lv') && g:loaded_lv
    finish
endif
let g:loaded_lv = 1


" Git

let s:git_current_branch = ''

function! s:git_refresh()
    let l:git_on = system('git -C ' . expand('%:p:h') .
                          \ ' symbolic-ref --short HEAD 2> /dev/null')
    if l:git_on != ''
        let s:git_current_branch = 'git:' . substitute(l:git_on, '\n$', '', '')
    else
        let s:git_current_branch = ''
    end
endfunction

augroup LvGitStatus
    au!
    au BufEnter * call <SID>git_refresh()
augroup END

function! lv#git_branch()
    return s:git_current_branch
endfunction


" Status line

let s:last_status_mode = ''
let s:last_status_mode_ret = ''

function! lv#stl_mode()
    let l:status_mode = mode()

    if l:status_mode != s:last_status_mode
        if l:status_mode == 'n'
            highlight LvStatusModeHL ctermbg=4 ctermfg=16
            let s:last_status_mode_ret = 'N'
        elseif l:status_mode == 'v' || l:status_mode == 'V' || l:status_mode == ''
            highlight LvStatusModeHL ctermbg=3 ctermfg=16
            let s:last_status_mode_ret = 'V'
        elseif l:status_mode == 's' || l:status_mode == 'S' || l:status_mode == ''
            highlight LvStatusModeHL ctermbg=5 ctermfg=16
            let s:last_status_mode_ret = 'S'
        elseif l:status_mode == 'i'
            highlight LvStatusModeHL ctermbg=2 ctermfg=16
            let s:last_status_mode_ret = 'I'
        elseif l:status_mode == 'R'
            highlight LvStatusModeHL ctermbg=1 ctermfg=16
            let s:last_status_mode_ret = 'R'
        elseif l:status_mode == 'Rv'
            highlight LvStatusModeHL ctermbg=1 ctermfg=16
            let s:last_status_mode_ret = 'v'
        else
            highlight LvStatusModeHL ctermbg=4 ctermfg=16
            let s:last_status_mode_ret = l:status_mode
        endif
        let s:last_status_mode = l:status_mode
    endif

    return s:last_status_mode_ret
endfunction


function! s:lv_statusline()
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
        let s:stl_active .= '%#LvStatusModeHL# %{lv#stl_mode()} '  " mode.
        let s:stl_active .= '%4* %n '                              " buffer.
        let s:stl_active .= '%3* %{&fenc != "" ? &fenc : &enc} '   " encoding.
        let s:stl_active .= '%2* %{&ff} '                          " format.
        let s:stl_active .= '%1* %t '                              " file name.
        let s:stl_active .= '%{&modified != "" ? "±" : " "} '      " modified.
        let s:stl_active .= '%r '                                  " read-only.
        let s:stl_active .= '%{lv#git_branch()}'                     " git info.
        let s:stl_active .= '%='                                   " right align.
        let s:stl_active .= ' %Y '                                 " file type.
        let s:stl_active .= '%2* R%5l '                            " row.
        let s:stl_active .= '%3* C%5v '                            " col.
        let s:stl_active .= '%4* %3p%% '                           " scroll %.

        highlight User1 ctermbg=235 ctermfg=231
        highlight User2 ctermbg=248 ctermfg=16
        highlight User3 ctermbg=250 ctermfg=16
        highlight User4 ctermbg=252 ctermfg=16
        highlight LvStatusModeHL ctermbg=4 ctermfg=16

        augroup LvStatusLine
            au!
            au VimEnter,WinEnter,BufWinEnter * let &l:statusline = s:stl_active
            au WinLeave,BufWinLeave * let &l:statusline = ''
        augroup END
    endif
endfunction

call s:lv_statusline()
