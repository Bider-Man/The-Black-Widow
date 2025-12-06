// Import Modules
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

// Main Config
Item{
    id: batteryCircle
    implicitWidth: 30
    implicitHeight: 30
    Layout.alignment: Qt.AlignVCenter

    property var battery: UPower.displayDevice
    property color ringColor:{
        if (!battery.ready) return 
    }
}
