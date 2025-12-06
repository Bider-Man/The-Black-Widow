// Import modules
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.bar.widgets

// Main Config
PanelWindow{
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#1a1b26"

    RowLayout{
        anchors.fill: parent
        spacing: 10
        
        Item{Layout.preferredWidth: 15} // Pushes the widgets a few pixels to the right

        // CPU, Memory and Swap Info
        Utils{}

        Item{Layout.fillWidth: true} // Pushes the Widgets to the left

        // Workspace Info
        Workspaces{}

        Item{Layout.fillWidth: true}

        // Clock Info
        Clock{}

        Item{Layout.fillWidth: true}
    }
}
