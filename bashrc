[[ $- != *i* ]] && return
fastfetch&
T1=$!
eval "$(starship init bash&)"
T2=$!
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nixcommit='bash /home/$(whoami)/.config/hypr/scripts/nix_update.sh'
alias nit='cd /etc/nixos && sudoedit /etc/nixos/configuration.nix'
alias cd='z'
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
wait $T1 $T2
eval "$(thefuck --alias)"&
eval "$(zoxide init bash)"
