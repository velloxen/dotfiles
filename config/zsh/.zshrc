export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# TODO: starship in devenv and nix-shell
# ANSWER: it's as easy as entering `zsh`
eval "$(starship init zsh)"
