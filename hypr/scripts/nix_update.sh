sudo nix-channel --update
cd ~
rm ./result
nixos-rebuild build "$@" || exit 1
clear
nvd diff /run/current-system ./result 
while true; do
    read -p "Do you want to commit this change? (Y/n)" yn
    case $yn in
        [Yy]* ) sudo nixos-rebuild switch "$@" || { echo 'rebuild has failed' ; exit 1; }; break;;
        [Nn]* ) exit;;
        * ) echo "Answer Y/n";;
    esac
done
cd /home/$(whoami)/.config
cp /home/$(whoami)/.bashrc /home/$(whoami)/.config/bashrc
cp /etc/nixos/* /home/$(whoami)/.config/nixOS/.
git add .
git commit
git push -u origin main
#while true; do
#    read -p "Do you want to backup your system before building? (Y/n)" yn
#    case $yn in
#        [Yy]* ) bash "/home/hexolexo/.config/hypr/scripts/backup.sh" || { echo 'Backup has failed' ; exit 1; }; break;;
#        [Nn]* ) break;;
#        * ) echo "Answer Y/n";;
#    esac
#done
