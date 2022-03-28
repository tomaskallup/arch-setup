autoload -Uz vcs_info
autoload -U colors && colors
setopt promptsubst

zstyle ':vcs_info:*' formats '%b'

precmd () {
  vcs_info

  STATUS=$(command git status --porcelain --untracked-files=no 2> /dev/null | tail -n1)

  if [[ ! -z $STATUS ]]; then
    local git_branch='%F{10}$vcs_info_msg_0_'
  else
    local git_branch='%F{6}$vcs_info_msg_0_'
  fi

  PROMPT="%F{40}[%F{10}%n%F{6}@%F{20}%m%F{40}]%c%{$reset_color%} "

  BRANCH=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if [[ ! -z $BRANCH ]]; then

    PROMPT="$PROMPT%{$reset_color%}(%F{1}%{$git_branch%}%{$reset_color%}) "
  fi

  TIME_FORMATTED=$(date +"%H:%M:%S")

  PROMPT="$PROMPT%F{1}[%{$reset_color%}$TIME_FORMATTED%F{1}]%{$reset_color%}"

  PROMPT="$PROMPT"$'\n'"%F{5}$%{$reset_color%} "
}
