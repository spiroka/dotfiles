export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(zsh-syntax-highlighting git)

source $ZSH/oh-my-zsh.sh

# Enable pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Enable vi mode
bindkey -v

# Alias for NeoVim
alias vim=~/nvim/bin/nvim
