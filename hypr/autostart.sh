# Fancy Stuff
/home/jackson/.config/eww/launch_bar &
/home/jackson/.scripts/wallpapers.sh -i &
swaync &

# Useful Stuff
/usr/bin/emacs --daemon &
headsetcontrol -l 0 &

# Steam was being a pain
xrandr --output HDMI-A-1 --primary &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || mpd-mpris &

# Run Once
pgrep -x companion.sh > /dev/null || /home/jackson/.scripts/companion.sh &

pgrep -x thunderbird > /dev/null || thunderbird &
pgrep -x signal-desktop > /dev/null || signal-desktop --ozone-platform=wayland &
pgrep -x DiscordCanary > /dev/null || discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
