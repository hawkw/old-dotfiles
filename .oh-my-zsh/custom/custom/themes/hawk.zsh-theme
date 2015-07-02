setopt promptsubst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats "%{$fg[yellow]%}‹%b%m%u%c› %{$reset_color%}"

precmd() {
    vcs_info
}

setopt prompt_subst
if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="black"; fi

local return_code="%(?..%{$fg[red]%}%? ↵) %{$fg[black]%}[%*]%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"


PROMPT='%{${fg[magenta]}%}%m%{$reset_color%} %{${fg_bold[black]}%}:: %{$reset_color%}%{${fg[magenta]}%}%3~ %{$reset_color%}${vcs_info_msg_0_}%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"
