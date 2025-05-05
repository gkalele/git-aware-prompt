find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
        branch='detached*'
    else
        if [[ ${#branch} -gt 27 ]]; then
            # Truncate the string to max_length characters
            truncated_string="${branch:0:27}"
            git_branch="($truncated_string...)"
        else
            git_branch="($branch)"
        fi
    fi
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

#PROMPT_COMMAND="find_git_branch; find_git_dirty"
PROMPT_COMMAND=""
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
export PS1="\u@Mac [ws:$WS] \W \[$txtcyn\]\$git_branch \$ "

# Another variant:
export PS1="\[$txtgrn\]\u@Mac\[$txtrst\] \w \[$txtcyn\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
