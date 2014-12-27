if (exists('g:lvgit_loaded') && g:lvgit_loaded)
  finish
endif


let g:lvgit_loaded = 1
let b:lvgit_status = ""

function! s:lvgit_refresh()
  let l:git_on = system("git -C " . expand("%:p:h") .
                        \ " symbolic-ref --short HEAD 2> /dev/null")
  if l:git_on != ""
    let b:lvgit_status = "git:" . substitute(l:git_on, "\n$", "", "")
  else
    let b:lvgit_status = ""
  end
endfunction

hi LvGitBranchName guifg=#7cafc2
hi LvGitBranchPrefix guifg=#ba8baf
autocmd BufEnter * call <SID>lvgit_refresh()

function! LvGitBranch()
  return b:lvgit_status
endfunction
