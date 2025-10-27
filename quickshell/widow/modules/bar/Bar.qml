// Import Modules
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common
import qs.modules.bar.widgets

// Main Config for the Bar
Scope{
    id: bar

    Variants{
        model: Quickshell.screens

        PanelWindow{
            id: root
            visible: content.length > 0
            required property var modelData
            screen: modelData

            color: "gray"

            anchors{
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            Row{
                id: contentRow
                anchors.fill: parent
                spacing: 10

                // Left side widgets

                // Center widgets
                Clock{
                    anchors.centerIn: parent
                }

                //Right side widgets
                Battery{}
            }

        }
    }
}
