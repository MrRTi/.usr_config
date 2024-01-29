#! /bin/zsh

if [[ -f $(brew --prefix)/opt/gitstatus/gitstatus.plugin.zsh ]]; then
  source $(brew --prefix)/opt/gitstatus/gitstatus.plugin.zsh
fi
if [[ -f ~/gitstatus/gitstatus.plugin.zsh ]]; then 
  source ~/gitstatus/gitstatus.plugin.zsh 
fi


NEWLINE=$'\n'

function my_set_prompt() {
  #RPROMPT="%?"
  PROMPT="%F{cyan}%n@%m %F{yellow}%~ %F{blue}"

  if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
    PROMPT+="%F{green}${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}"  # escape %

    local      clean='%76F'   # green foreground
    local   modified='%178F'  # yellow foreground
    local  untracked='%39F'   # blue foreground
    local conflicted='%196F'  # red foreground

    # ⇣42 if behind the remote.
    (( VCS_STATUS_COMMITS_BEHIND )) && PROMPT+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && PROMPT+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && PROMPT+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    # ⇠42 if behind the push remote.
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && PROMPT+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && PROMPT+=" "
    # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && PROMPT+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    # *42 if have stashes.
    (( VCS_STATUS_STASHES        )) && PROMPT+=" ${clean}*${VCS_STATUS_STASHES}"
    # 'merge' if the repo is in an unusual state.
    [[ -n $VCS_STATUS_ACTION     ]] && PROMPT+=" ${conflicted}${VCS_STATUS_ACTION}"
    # ~42 if have merge conflicts.
    (( VCS_STATUS_NUM_CONFLICTED )) && PROMPT+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    # +42 if have staged changes.
    (( VCS_STATUS_NUM_STAGED     )) && PROMPT+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    # !42 if have unstaged changes.
    (( VCS_STATUS_NUM_UNSTAGED   )) && PROMPT+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    # ?42 if have untracked files. It's really a question mark, your font isn't broken.
    (( VCS_STATUS_NUM_UNTRACKED  )) && PROMPT+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

  fi

  PROMPT+="${NEWLINE}%(?..%B(%?%)%b)%F{green}>%f %"
  setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook precmd my_set_prompt

