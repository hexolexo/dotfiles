[[ $- != *i* ]] && return
eval "$(starship init bash)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nixcommit='bash /home/$(whoami)/.config/hypr/scripts/nix_update.sh'
alias nit='cd /etc/nixos && micro /etc/nixos/configuration.nix' # nix edit = nit
alias cargo='bash /home/$(whoami)/.config/hypr/scripts/cargo.sh'
PS1='[\u@\h \W]\$ '
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
