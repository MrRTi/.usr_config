[[ ! -z "${DOTFILES_PATH}" ]] || export DOTFILES_PATH=~/.dotfiles

# NOTE: Source all functions
for f in $DOTFILES_PATH/.config/bash/extensions/*.sh; do source $f; done

# NOTE: Exports
export PROMPT_COMMAND=prompt_command
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export EDITOR=nvim

# NOTE: Shell opts
shopt -s autocd

# NOTE: Load extensions
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
[ -f ~/yandex-cloud/completion.bash.inc ] && . ~/yandex-cloud/completion.bash.inc

# NOTE: Add gems executables to path
gembin=`(gem env | sed -n "s/.*EXECUTABLE DIRECTORY: \(.*\)/\1/p")`
export PATH=$gembin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
