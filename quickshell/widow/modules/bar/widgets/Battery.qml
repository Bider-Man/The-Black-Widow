// Import Modules
import QtQuick
import QtQuick.Layouts
import "../../common" as Common

// Main Config
RowLayout {
    id: batteryWidget
    spacing: 5
    Layout.alignment: Qt.AlignVCenter
    
    // Use theme colors for spacing/border elements
    readonly property color separatorColor: Common.Appearance.colors.colOutlineVariant
    
    Rectangle { 
        width: 1
        height: 16
        color: separatorColor
        Layout.alignment: Qt.AlignVCenter
        visible: true  // Separator between other widgets and battery
    }
    
    // Use the system command version instead of UPower
    BatterySystem {}
}
