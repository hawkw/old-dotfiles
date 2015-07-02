autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' stagedstr '%F{green}●%F{yellow}'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%F{yellow}'
zstyle ':vcs_info:git*' formats '‹±%b%m%u%c› '
zstyle ':vcs_info:hg*' formats '‹☿%b%m%u%c› '
zstyle ':vcs_info:svn*' formats '‹⚡%b%m%u%c› '
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | sed 's/^[ \t]*//')
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | sed 's/^[ \t]*//')
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
}
### git: Show remote branch name for remote-tracking branches
function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        hook_com[branch]="${hook_com[branch]} [${remote}]"
    fi
}

precmd() {
    vcs_info
}

if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="black"; fi

local return_code='%(?..%{$fg[red]%}%? ↵) %{$fg[black]%}[%*]%{$reset_color%}'

setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

PROMPT='%F{magenta}%m%f %{${fg_bold[black]}%}:: %{$reset_color%}%{${fg[magenta]}%}%3~ %{$reset_color%}%F{yellow}${vcs_info_msg_0_}%f%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"
