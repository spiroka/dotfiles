export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(git zsh-syntax-highlighting git)

source $ZSH/oh-my-zsh.sh

# Enable pure prompt
autoload -U promptinit; promptinit
prompt pure

# Enable vi mode
bindkey -v

# Alias for NeoVim
alias vim=~/nvim-macos/bin/nvim
