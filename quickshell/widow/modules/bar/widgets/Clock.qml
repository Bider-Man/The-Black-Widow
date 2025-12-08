// Import Modules
import QtQuick
import qs.common as Common

// Main config
Item {
    id: root
    height: 23
    width: clock.contentWidth + 20  // Dynamic width based on content
    
    // Use theme colors
    readonly property color colText: Common.Appearance.colors.colPrimary
    readonly property string fontFamily: Common.Appearance.font.family.main
    readonly property int fontSize: Common.Appearance.font.pixelSize.large

    // Clock
    Text {
        id: clock
        anchors.centerIn: parent
        color: root.colText
        font { 
            family: root.fontFamily
            pixelSize: root.fontSize
            bold: true 
        }
        text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")
        }
    }
}
