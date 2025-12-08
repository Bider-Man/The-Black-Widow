// Import Modules
import QtQuick
import QtQuick.Layouts

// Main Config
RowLayout {
    id: batteryWidget
    spacing: 5
    Layout.alignment: Qt.AlignVCenter
    
    // Use the system command version instead of UPower
    BatterySystem {}
}
