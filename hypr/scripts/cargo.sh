sudo ectool --interface=lpc fanduty 100
cargo $@
sudo ectool --interface=lpc autofanctrl
