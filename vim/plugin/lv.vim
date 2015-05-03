if (exists('g:lv_loaded') && g:lv_loaded)
    finish
endif


let g:lv_loaded = 1


" Git

let b:git_status = ''

function! s:lv_git_refresh()
    let l:git_on = system('git -C ' . expand('%:p:h') .
                          \ ' symbolic-ref --short HEAD 2> /dev/null')
    if l:git_on != ''
        let b:git_status = 'git:' . substitute(l:git_on, '\n$', '', '')
    else
        let b:git_status = ''
    end
endfunction

augroup LvGitStatus
    au!
    au BufEnter * call <SID>lv_git_refresh()
augroup END

function! LvGitBranch()
    return b:git_status
endfunction
