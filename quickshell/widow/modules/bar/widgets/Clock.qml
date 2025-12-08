// Import Modules
import QtQuick

// Main config

Item {
    id: root
    height: 23
    width: clock.contentWidth + 20  // Dynamic width based on content
    
    // Theme
    property color colRed: "#c84c4c"   // Medium red
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 17

    // Clock
    Text {
        id: clock
        anchors.centerIn: parent
        color: root.colRed
        font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")
        }
    }
}
