# Found on the ZshWiki
#  http://zshwiki.org/home/config/prompt


# Funciones

function lv_prompt() {
    wd="%(4~.…%3~.%~)"

    prompt="┼─[%{$fg_no_bold[cyan]%}%n%{$reset_color%}@%{$fg_no_bold[yellow]%}%m%{$reset_color%} ${wd}]$(git_prompt_info)$(hg_prompt_info)\n└╼"
    echo $prompt
}

# ┤├

# Prompts
PROMPT='
$(lv_prompt)%{$fg_no_bold[green]%}%#%{$reset_color%} '

_REPO_PROMPT_PREFIX="─[%%{$fg_no_bold[blue]%%}%s%%{$reset_color%%}:%%{$fg_no_bold[magenta]%%}"
_REPO_PROMPT_SUFFIX="%{$reset_color%}]"
_REPO_PROMPT_DIRTY="%{$reset_color%}]─[%{$fg_no_bold[red]%}±"
_REPO_PROMPT_CLEAN="%{$reset_color%}]─[%{$fg_no_bold[green]%}✓"
ZSH_THEME_GIT_PROMPT_PREFIX=`printf $_REPO_PROMPT_PREFIX "git"`
ZSH_THEME_GIT_PROMPT_SUFFIX=$_REPO_PROMPT_SUFFIX
ZSH_THEME_GIT_PROMPT_DIRTY=$_REPO_PROMPT_DIRTY
ZSH_THEME_GIT_PROMPT_CLEAN=$_REPO_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=`printf $_REPO_PROMPT_PREFIX "☿"`
ZSH_THEME_HG_PROMPT_SUFFIX=$_REPO_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$_REPO_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$_REPO_PROMPT_CLEAN

unset _REPO_PROMPT_PREFIX
unset _REPO_PROMPT_SUFFIX
unset _REPO_PROMPT_DIRTY
unset _REPO_PROMPT_CLEAN
