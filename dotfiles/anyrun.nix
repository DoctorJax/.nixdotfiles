{ config, lib, pkgs, inputs, ... }: {

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        translate
        rink
        stdin
      ];

      width.absolute = 800;
      y.fraction = 0.28;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
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
