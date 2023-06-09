{ config, lib, pkgs, inputs, ... }:
  let
    inherit (inputs.anyrun.packages.${pkgs.system}) anyrun;
  in
{
  home.packages = [anyrun];

  xdg.configFile = {
    "anyrun/config.ron".text = ''
      Config(
        // `width` and `vertical_offset` use an enum for the value it can be either:
        // Absolute(n): The absolute value in pixels
        // Fraction(n): A fraction of the width or height of the full screen (depends on exclusive zones and the settings related to them) window respectively

        // How wide the input box and results are.
        width: Absolute(800),

        // Where Anyrun is located on the screen: Top, Center
        position: Center,

        // How much the runner is shifted vertically
        vertical_offset: Fraction(-0.28),

        // Hide match and plugin info icons
        hide_icons: false,

        // ignore exclusive zones, f.e. Waybar
        ignore_exclusive_zones: false,

        // Layer shell layer: Background, Bottom, Top, Overlay
        layer: Overlay,

        // Hide the plugin info panel
        hide_plugin_info: true,

        close_on_click: true,

        show_results_immediately: false,

        // List of plugins to be loaded by default, can be specified with a relative path to be loaded from the
        // `<anyrun config dir>/plugins` directory or with an absolute path to just load the file the path points to.
        plugins: [
          "${anyrun}/lib/libapplications.so",
          "${anyrun}/lib/libshell.so",
          "${anyrun}/lib/libtranslate.so",
          "${anyrun}/lib/librink.so",
          "${anyrun}/lib/libstdin.so",
        ],
      )
    '';

    "anyrun/style.css".text = ''
      * {
        transition: 200ms ease;
        font-family: JetBrains Mono Nerd Font;
        font-size: 1.3rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        color: white;
        background: transparent;
      }

      #match:selected {
        background: rgba(203, 166, 247, 0.7);
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #plugin:hover {
        border-radius: 16px;
      }

      #entry {
        box-shadow: none;
        border: 2px solid rgba(203, 166, 247, 0.7);
        border-radius: 20px;
      }

      box#main {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid #28283d;
        border-radius: 24px;
        padding: 8px;
      }
    '';
  };
}
