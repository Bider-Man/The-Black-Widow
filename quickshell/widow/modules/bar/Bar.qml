// Import Modules
import Quickshell // For PanelWindow
import QtQuick // For Text
import "widgets" // Import Widgets config
import Quickshell.Services.UPower

// Main config
Scope {
    Variants {
        model: Quickshell.screens


        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            ClockWidget {
                anchors.centerIn: parent
            }

            Battery {
                visible: (barRoot.useShortnedForm < 2 && UPower.displayDevice.isLaptopBattery)
                anchors.centerIn: left
            }
        }
    }
}
