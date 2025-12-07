// Import Modules
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Services.UPower
import "./modules/bar"

// Main Config
ShellRoot{
    id: root

    Bar{}
    ReloadPopup{}
}
