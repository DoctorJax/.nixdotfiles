{ config, lib, pkgs, ... }:

{
  home = {
    packages = [pkgs.swaynotificationcenter];

    file = {
      ".config/swaync/config.json".text = ''
        {
          "$schema": "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json",
          "positionX": "right",
          "positionY": "top",
          "layer": "top",
          "cssPriority": "application",
          "control-center-margin-top": 0,
          "control-center-margin-bottom": 0,
          "control-center-margin-right": 0,
          "control-center-margin-left": 0,
          "notification-2fa-action": false,
          "notification-icon-size": 64,
          "notification-body-image-height": 100,
          "notification-body-image-width": 200,
          "timeout": 8,
          "timeout-low": 8,
          "timeout-critical": 0,
          "fit-to-screen": true,
          "control-center-width": 500,
          "control-center-height": 600,
          "notification-window-width": 500,
          "keyboard-shortcuts": true,
          "image-visibility": "when-available",
          "transition-time": 200,
          "hide-on-clear": false,
          "hide-on-action": true,
          "script-fail-notify": true,
          "scripts": {
            "example-script": {
              "exec": "echo 'Do something...'",
              "urgency": "Normal"
            },
            "example-action-script": {
              "exec": "echo 'Do something actionable!'",
              "urgency": "Normal",
              "run-on": "action"
            }
          },
          "notification-visibility": {
            "example-name": {
              "state": "muted",
              "urgency": "Low",
              "app-name": "Spotify"
            }
          },
          "widgets": [
            "title",
            "mpris",
            "notifications"
          ],
          "widget-config": {
            "inhibitors": {
              "text": "Inhibitors",
              "button-text": "Clear All",
              "clear-all-button": true
            },
            "title": {
              "text": "Notifications",
              "clear-all-button": true,
              "button-text": "Clear All"
            },
            "dnd": {
              "text": "Do Not Disturb"
            },
            "label": {
              "max-lines": 5,
              "text": "Label Text"
            },
            "mpris": {
              "image-size": 96,
              "image-radius": 12
            }
          }
        }
      '';

      ".config/swaync/style.css".text = ''
        /*
         * vim: ft=less
         */

        @define-color cc-bg rgba(0, 0, 0, 0.7);

        @define-color noti-border-color #5ADECD;
        @define-color noti-bg rgba(20, 20, 20, 0.8);
        @define-color noti-bg-hover rgba(30, 30, 30, 0.8);
        @define-color noti-bg-focus rgba(68, 68, 68, 0.6);
        @define-color noti-close-bg rgba(255, 255, 255, 0.1);
        @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);

        @define-color bg-selected rgb(0, 128, 255);

        .notification-row {
          outline: none;
        }

        .notification-row:focus,
        .notification-row:hover {
          background: @noti-bg-focus;
        }

        .notification {
          border-radius: 12px;
          margin: 6px;
          box-shadow: none;
          padding: 0;
        }

        /* Uncomment to enable specific urgency colors
        .low {
          background: yellow;
          padding: 6px;
          border-radius: 12px;
        }

        .normal {
          background: green;
          padding: 6px;
          border-radius: 12px;
        }

        .critical {
          background: red;
          padding: 6px;
          border-radius: 12px;
        }
        */

        .notification-content {
          background: transparent;
          padding: 6px;
          border-radius: 12px;
          font-family: Product Sans, mononoki Nerd Font;
        }

        .close-button {
          opacity: 0;
        }

        .notification-default-action,
        .notification-action {
          padding: 4px;
          margin: 0;
          box-shadow: none;
          background: @noti-bg;
          border: 2px solid @noti-border-color;
          color: white;
        }

        .notification-default-action:hover,
        .notification-action:hover {
          -gtk-icon-effect: none;
          background: @noti-bg-hover;
        }

        .notification-default-action {
          border-radius: 12px;
        }

        /* When alternative actions are visible */
        .notification-default-action:not(:only-child) {
          border-bottom-left-radius: 0px;
          border-bottom-right-radius: 0px;
        }

        .notification-action {
          border-radius: 0px;
          border-top: none;
          border-right: none;
        }

        /* add bottom border radius to eliminate clipping */
        .notification-action:first-child {
          border-bottom-left-radius: 10px;
        }

        .notification-action:last-child {
          border-bottom-right-radius: 10px;
          border-right: 1px solid @noti-border-color;
        }

        .image {
          border: 1px solid #282a36;
          border-radius: 12px;
        }

        .body-image {
          margin-top: 6px;
          background-color: white;
          border-radius: 12px;
        }

        .summary {
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: white;
          text-shadow: none;
        }

        .time {
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: white;
          text-shadow: none;
          margin-right: 18px;
        }

        .body {
          font-size: 15px;
          font-weight: normal;
          background: transparent;
          color: white;
          text-shadow: none;
        }

        .control-center {
          background: @cc-bg;
        }

        .control-center-list {
          background: transparent;
        }

        .control-center-list-placeholder {
          opacity: 0.5;
        }

        .floating-notifications {
          background: transparent;
        }

        /* Window behind control center and on all other monitors */
        .blank-window {
          background: transparent;
        }

        /*** Widgets ***/

        /* Title widget */
        .widget-title {
          margin: 8px;
          font-size: 1.5rem;
        }
        .widget-title > button {
          font-size: initial;
          color: white;
          text-shadow: none;
          background: @noti-bg;
          border: 2px solid @noti-border-color;
          box-shadow: none;
          border-radius: 12px;
        }
        .widget-title > button:hover {
          background: @noti-bg-hover;
        }

        /* DND widget */
        .widget-dnd {
          margin: 8px;
          font-size: 1.1rem;
        }
        .widget-dnd > switch {
          font-size: initial;
          border-radius: 12px;
          background: @noti-bg;
          border: 2px solid @noti-border-color;
          box-shadow: none;
        }
        .widget-dnd > switch:checked {
          background: @bg-selected;
        }
        .widget-dnd > switch slider {
          background: @noti-bg-hover;
          border-radius: 12px;
        }

        /* Label widget */
        .widget-label {
          margin: 8px;
        }
        .widget-label > label {
          font-size: 1.1rem;
        }

        /* Mpris widget */
        .widget-mpris {
          /* The parent to all players */
        }
        .widget-mpris-player {
          padding: 8px;
          margin: 8px;
        }
        .widget-mpris-title {
          font-weight: bold;
          font-size: 1.25rem;
        }
        .widget-mpris-subtitle {
          font-size: 1.1rem;
        }

        /* Buttons widget */
        .widget-buttons-grid {
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
          background-color: @noti-bg;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button{
          background: @noti-bg;
          border-radius: 12px;
        }

        .widget-buttons-grid>flowbox>flowboxchild>button:hover {
          background: @noti-bg-hover;
        }

        /* Menubar widget */
        .widget-menubar>box>.menu-button-bar>button {
          border: none;
          background: transparent;
        }

        /* .AnyName { Name defined in config after #
          background-color: @noti-bg;
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
        }

        .AnyName>button {
          background: transparent;
          border: none;
        }

        .AnyName>button:hover {
          background-color: @noti-bg-hover;
        } */

        .topbar-buttons>button { /* Name defined in config after # */
          border: none;
          background: transparent;
        }

        /* Volume widget */

        .widget-volume {
          background-color: @noti-bg;
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
        }

        /* Backlight widget */
        .widget-backlight {
          background-color: @noti-bg;
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
        }

        /* Title widget */
        .widget-inhibitors {
          margin: 8px;
          font-size: 1.5rem;
        }
        .widget-inhibitors > button {
          font-size: initial;
          color: white;
          text-shadow: none;
          background: @noti-bg;
          border: 2px solid @noti-border-color;
          box-shadow: none;
          border-radius: 12px;
        }
        .widget-inhibitors > button:hover {
          background: @noti-bg-hover;
        }
      '';
    };
  };
}
