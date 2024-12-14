[[ $- != *i* ]] && return
fastfetch& 
T1=$!
eval "$(starship init bash&)" 
alias ls='ls --color=auto' grep='grep --color=auto' nixcommit='bash /home/$(whoami)/.config/hypr/scripts/nix_update.sh' nit='cd /etc/nixos && sudoedit /etc/nixos/configuration.nix' man='bash /home/hexolexo/.config/hypr/scripts/man.sh'
wait $T1
eval "$(thefuck --alias)"&
eval "$(zoxide init bash)" && alias cd='z'



