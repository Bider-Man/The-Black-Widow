// Import Modules
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.UPower

// Import User folders

import "./modules/bar/"
import "./modules/notifications/"
import "./services/"

// Main Config
ShellRoot{
    id: root

    Bar{}
    NotificationPanel{}
    ReloadPopup{}
}
