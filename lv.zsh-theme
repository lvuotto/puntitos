# Found on the ZshWiki
#  http://zshwiki.org/home/config/prompt


# Funciones

function lv_prompt() {
    wd=${PWD/$HOME/\~}
    ((fill_l=(${COLUMNS} - 1) - 2 - (${#USER} + ${#HOST} + 3) - (${#wd} + 2) - 1 - 1))
    git_info=$(git_prompt_info)
    if [[ ! -z "$git_info" ]]; then
        clean_git_info=$(echo $git_info | sed "s/%{[^%]*%}//g")
        ((fill_l=$fill_l - ${#clean_git_info})) # " git, on branch $branch "
    fi
    fill=""
    while [[ $#fill -lt $fill_l ]]; do fill="${fill}─"; done

    prompt="┌ %{$fg_no_bold[cyan]%}%n%{$reset_color%}@%{$fg_bold[yellow]%}%m%{$reset_color%} ─ ${wd} ─${fill}${git_info}┐\n└ "
    echo $prompt
}

# Prompts
PROMPT='
$(lv_prompt)%{$reset_color%}'
RPROMPT='┘'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_no_bold[blue]%}git%{$reset_color%}, on branch %{$fg_no_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_no_bold[red]%} ±"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_no_bold[green]%} ✓"