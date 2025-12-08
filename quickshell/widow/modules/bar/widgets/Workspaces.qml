// Import Modules
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.common as Common

// Main Config
RowLayout{
    anchors.fill: parent.center
    anchors.centerIn: parent
    anchors.margins: 10

    Repeater{
        model: 10

        Text{
            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            text: index + 1
            color: {
                if (isActive) {
                    return Common.Appearance.m3colors.workspaceActive
                } else if (ws) {
                    return Common.Appearance.m3colors.workspaceInactive
                } else {
                    return Common.Appearance.m3colors.workspaceEmpty
                }
            }
            font {
                pixelSize: Common.Appearance.font.pixelSize.large
                bold: true
                family: Common.Appearance.font.family.main
            }

            MouseArea{
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
            }
        }
    }
}
