// Import Modules
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.services
import qs.modules.bar.widgets

// Main Config for the Bar
Scope{
    Variants{
        model: Quickshell.screens

        PanelWindow{
            required property var modelData
            screen: modelData

            anchors{
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            Clock{
                anchors.centerIn: parent
            }
        }
    }
}
