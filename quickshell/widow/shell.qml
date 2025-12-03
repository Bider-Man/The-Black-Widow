// Black Widow Quickshell shell.qml file

import Quickshell
import Quickshell.Hyprland
import QtQuick
import "common"
import "service"
import "modules/bar"
import "modules/dock"
import "modules/sidepanel"
import "modules/notifications"

ShellRoot{
    // Load the settings and themes
    Settings{
        id: settings
    }

    // Initialize all services
    AudioService{id: audioservice}
    BatteryService{id: batteryservice}
    BluetoothService{id: bluetoothservice}
    BrightnessService{id: brightnessservice}
    MediaService{id: mediaservice}
    NetworkService{id: networkservice}
    NotificationService{id: notificationservice}
    WallpaperService{id: wallpaperservice}
    WorkspaceService{id: workspaceservice}

    // Create the bar on each monitor
    Variants{
        variants: HyprlandMonitor.all
        Bar{
            monitor: modelData
        }
    }

    // Create a single instance of dock
    Dock{
        id: dock
    }

    // Create the side panel
    SidePanel{
        id: sidePanel
    }

    // Create OSD notifications
    OSD{
        id: osd
    }
}
