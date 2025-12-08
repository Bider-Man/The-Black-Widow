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

    Item {
        anchors.fill: parent
        
        // Left-aligned Utils
        Utils {
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // Workspaces centered
        Workspaces {
            id: workspaces
            anchors.centerIn: parent
        }
        
        // Clock to the right of Workspaces
        Clock {
            id: clock
            anchors.left: workspaces.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // Battery to the right of Clock
        Battery {
            anchors.left: clock.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

    }
}
