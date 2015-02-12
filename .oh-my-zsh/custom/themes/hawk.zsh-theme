if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="black"; fi

local return_code="%(?..%{$fg[red]%}%? ↵) %{$fg[black]%}[%*]%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

function git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

PROMPT="%{${fg[magenta]}%}%m%{$reset_color%} %{${fg_bold[black]}%}:: %{$reset_color%}%{${fg[magenta]}%}%3~ %{$reset_color%}$(git_prompt)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} "

RPS1="${return_code}"