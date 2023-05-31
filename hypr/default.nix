{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    jaq
    xorg.xprop
  ];

  home.file = {
    ".config/hypr/autostart.sh".text = ''
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
    '';
  };

  wayland.windowManager.hyprland.extraConfig = ''
    # -------------------------
    # Monitors
    # -------------------------
    monitor=HDMI-A-1,2560x1080@75,1920x0,1
    monitor=DP-3,1920x1080@75,0x0,1
    workspace=DP-3,1
    workspace=HDMI-A-1,11

    # -------------------------
    # Environment Variables
    # -------------------------
    env = CLUTTER_BACKEND,wayland
    env = XDG_SESSION_TYPE,wayland
    env = MOZ_ENABLE_WAYLAND,1
    env = WLR_BACKEND,vulkan
    env = QT_QPA_PLATFORM,wayland;xcb
    env = GDK_BACKEND,wayland,x11
    env = XDG_CURRENT_DESKTOP,hyprland
    env = XDG_SESSION_DESKTOP,hyprland
    env = XDG_CURRENT_SESSION_TYPE,wayland

    # -------------------------
    # Autostart
    # -------------------------
    exec=$HOME/.config/hypr/autostart.sh
    exec=$HOME/.config/hypr/portal-wlr.sh
    exec-once=$HOME/.local/share/hyprload/hyprload.sh

    # -------------------------
    # Hyprland Config
    # -------------------------
    input {
        kb_layout=us,us
        kb_variant=,colemak
        kb_model=
        kb_options=grp:alts_toggle
        kb_rules=

        repeat_rate=75
        repeat_delay=600
        numlock_by_default=1
        force_no_accel=1
        follow_mouse=1
    }

    general {
        sensitivity=1

        gaps_in=2
        gaps_out=2
        border_size=2
        col.active_border=0xFF008B8B
        col.inactive_border=0xFF282a36
    }

    decoration {
        rounding=10
        blur=1
        blur_size=2 # minimum 1
        blur_passes=3 # minimum 1, more passes = more resource intensive.
        # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
        # if you want heavy blur, you need to up the blur_passes.
        # the more passes, the more you can up the blur_size without noticing artifacts.
        dim_special=0.5
    }

    bezier=slow,0,0.85,0.3,1
    bezier=overshot,0.7,0.6,0.1,1.1
    bezier=bounce,1,1.6,0.1,0.85
    bezier=slingshot,1,-1,0.15,1.25
    bezier=nice,0,6.9,0.5,-4.20

    animations {
        enabled=1
        animation=windows,1,2,bounce,slide
        animation=border,1,2,default
        animation=fade,1,2,default
        animation=workspaces,1,2,overshot,slide
    }

    dwindle {
        pseudotile=0 # enable pseudotiling on dwindle
        preserve_split=1
        no_gaps_when_only=1
        special_scale_factor=0.9
    }

    binds {
        pass_mouse_when_bound=0
    }

    misc {
        animate_manual_resizes=0
        animate_mouse_windowdragging=0
        disable_hyprland_logo=1
        disable_splash_rendering=1
    }

    # -------------------------
    # Window Rules
    # -------------------------
    windowrule=workspace 1 silent,^(discord)$
    windowrule=workspace special:signal silent,^(signal)$
    windowrule=workspace special:mail silent,^(thunderbird)$

    windowrule=workspace 16 silent,^(Steam)$

    windowrule=float,^(MusicSelect)$
    windowrule=size 580 700,^(MusicSelect)$
    windowrule=center,^(MusicSelect)$

    windowrule=float,^(DateTime)$
    windowrule=size 223 42,^(DateTime)$
    windowrule=center,^(DateTime)$

    windowrule=float,title:^(Open File)(.*)$
    windowrule=float,title:^(Open Folder)(.*)$
    windowrule=float,title:^(Save As)(.*)$
    windowrule=float,title:^(Save File)(.*)$
    windowrule=float,title:^(Library)(.*)$

    layerrule=blur,^(gtk-layer-shell|anyrun|swaync-control-center)$
    layerrule=ignorezero,^(gtk-layer-shell|anyrun|swaync-control-center)$
    # -------------------------
    # Keybindings
    # -------------------------
    bind=SUPER,Q,killactive,
    bind=CONTROLSUPER,R,exec,hyprctl reload
    bind=CONTROLSUPER,Q,exit,

    bind=SUPER,h,movefocus,l
    bind=SUPER,l,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d

    bind=SUPER,comma,focusmonitor,l
    bind=SUPER,period,focusmonitor,r

    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPER,C,togglefloating,
    bind=SUPER,F,fullscreen,
    bind=SUPER,S,togglesplit,

    bind=SUPERCONTROL,Tab,togglegroup,
    bind=SUPER,Tab,changegroupactive,

    bind=SUPERSHIFT,R,hyprload,reload
    bind=SUPERSHIFT,U,hyprload,update

    bind=ALT,grave,exec,/home/jackson/.scripts/minimize.sh -q

    # launchers
    bind=CONTROL,grave,exec,kitty -1
    bind=SUPERSHIFT,E,exec,pcmanfm-qt
    bind=SUPER,E,exec,pkill -x anyrun || anyrun
    bind=CONTROLSUPER,S,exec,brave --profile-directory="Profile 1"
    bind=CONTROLSUPER,B,exec,firefox -P "Personal"
    bind=ALTSUPER,E,exec,emacsclient -a 'emacs' -c

    bind=SUPERSHIFT,S,exec,/home/jackson/.scripts/screenshot.sh
    bind=SUPERSHIFT,D,exec,/home/jackson/.scripts/screenshot.sh -t
    bind=SUPER,T,exec,/home/jackson/.scripts/systray.sh -t
    bind=SUPER,B,exec,/home/jackson/.scripts/systray.sh -b
    bind=SUPER,N,exec,swaync-client -t

    # audio
    bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
    bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
    bind=,XF86AudioMute,exec,amixer -q set Master toggle

    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioPrev,exec,playerctl previous
    bind=,XF86AudioPlay,exec,playerctl play-pause

    # mic mute
    bind=SUPERSHIFTCONTROLALT,M,exec,/home/jackson/.scripts/micmute.sh

    # random wallpaper
    bind=SUPER,F1,exec,/home/jackson/.scripts/wallpapers.sh -r
    bind=SUPER,F2,exec,/home/jackson/.scripts/wallpapers.sh -ra
    bind=SUPER,F3,exec,/home/jackson/.scripts/wallpapers.sh -rl
    bind=SUPER,grave,exec,/home/jackson/.scripts/wallpapers.sh -i

    # Workspaces for both monitors with split-monitor-workspaces plugin
    bind=SUPER,1,split-workspace,1
    bind=SUPER,2,split-workspace,2
    bind=SUPER,3,split-workspace,3
    bind=SUPER,4,split-workspace,4
    bind=SUPER,5,split-workspace,5
    bind=SUPER,6,split-workspace,6
    bind=SUPER,7,split-workspace,7
    bind=SUPER,8,split-workspace,8
    bind=SUPER,9,split-workspace,9
    bind=SUPER,0,split-workspace,10

    bind=SUPERSHIFT,1,split-movetoworkspacesilent,1
    bind=SUPERSHIFT,2,split-movetoworkspacesilent,2
    bind=SUPERSHIFT,3,split-movetoworkspacesilent,3
    bind=SUPERSHIFT,4,split-movetoworkspacesilent,4
    bind=SUPERSHIFT,5,split-movetoworkspacesilent,5
    bind=SUPERSHIFT,6,split-movetoworkspacesilent,6
    bind=SUPERSHIFT,7,split-movetoworkspacesilent,7
    bind=SUPERSHIFT,8,split-movetoworkspacesilent,8
    bind=SUPERSHIFT,9,split-movetoworkspacesilent,9
    bind=SUPERSHIFT,0,split-movetoworkspacesilent,10

    # Specials
    bind=SUPERCONTROL,1,togglespecialworkspace,discord
    bind=SUPERCONTROL,2,togglespecialworkspace,signal
    bind=SUPERCONTROL,3,togglespecialworkspace,mail

    bind=SUPERSHIFTCONTROL,1,movetoworkspace,special:discord
    bind=SUPERSHIFTCONTROL,2,movetoworkspace,special:signal
    bind=SUPERSHIFTCONTROL,3,movetoworkspace,special:mail

    # empty submap for keybinding passthrough
    bind=SUPERCTRLSHIFT,escape,submap,passthrough
    submap=passthrough
    bind=SUPERCTRLSHIFT,escape,submap,reset
    submap=reset
  '';
}
