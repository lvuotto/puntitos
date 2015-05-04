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

function! LvGitBranch()
    return s:git_current_branch
endfunction


" Status line

let s:last_status_mode = ''
let s:last_status_mode_ret = ''

function! LvStatusMode()
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


let s:status_active = ''
let s:status_active .= '%#LvStatusModeHL# %{LvStatusMode()} ' " mode.
let s:status_active .= '%4* %n '                              " buffer.
let s:status_active .= '%3* %{&fenc != "" ? &fenc : &enc} '   " encoding.
let s:status_active .= '%2* %{&ff} '                          " format.
let s:status_active .= '%1* %t '                              " file name.
let s:status_active .= '%{&modified != "" ? "±" : " "} '      " modified.
let s:status_active .= '%r '                                  " read-only.
let s:status_active .= '%{LvGitBranch()}'                     " git info.
let s:status_active .= '%='                                   " right align.
let s:status_active .= ' %Y '                                 " file type.
let s:status_active .= '%2* R%5l '                            " row.
let s:status_active .= '%3* C%5v '                            " col.
let s:status_active .= '%4* %3p%% '                           " scroll %.

let s:status_inactive = ''
let s:status_inactive .= ' - '
let s:status_inactive .= ' %n '                            " buffer.
let s:status_inactive .= ' %{&fenc != "" ? &fenc : &enc} ' " encoding.
let s:status_inactive .= ' %{&ff} '                        " format.
let s:status_inactive .= ' %t '                            " filename.
let s:status_inactive .= '%{&modified != "" ? "±" : " "} ' " modified.
let s:status_inactive .= '%r '                             " read-only.
let s:status_inactive .= '%='                              " right-align.
let s:status_inactive .= ' %Y '                            " file type.
let s:status_inactive .= ' R%5l '                          " row.
let s:status_inactive .= ' C%5v '                          " col.
let s:status_inactive .= ' %3p%% '                         " scroll %.


function! s:lv_status_line(active)
    if has('statusline')
        let &l:statusline = (a:active == 1 ? s:status_active : s:status_inactive)
    endif
endfunction

augroup LvStatusLine
    au!
    au VimEnter,WinEnter,BufWinEnter * call <SID>lv_status_line(1)
    au WinLeave,BufWinLeave * call <SID>lv_status_line(0)
augroup END

highlight User1 ctermbg=235 ctermfg=231
highlight User2 ctermbg=248 ctermfg=16
highlight User3 ctermbg=250 ctermfg=16
highlight User4 ctermbg=252 ctermfg=16
highlight LvStatusModeHL ctermbg=4 ctermfg=16
