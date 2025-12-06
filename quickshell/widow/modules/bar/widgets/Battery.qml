// Import Modules
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

// Main Config
RowLayout{
    id: batteryWidget
    spacing: 5

    // Battery Constants
    property var battery: UPower.displayDevice
}
