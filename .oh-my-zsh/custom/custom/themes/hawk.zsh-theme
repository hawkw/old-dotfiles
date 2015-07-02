setopt promptsubst
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats '‹%s:%b%m%i%u%c› '
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

precmd() {
    vcs_info
}

if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="black"; fi

local return_code='%(?..%{$fg[red]%}%? ↵) %{$fg[black]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"


PROMPT='%{${fg[magenta]}%}%m%{$reset_color%} %{${fg_bold[black]}%}:: %{$reset_color%}%{${fg[magenta]}%}%3~ %{$reset_color%}${vcs_info_msg_0_}%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"
