// Import Modules
import QtQuick

// Main config

Item{
    id: root
    width: 475
    height: 23
    
    // Theme
    property color colRed: "#c84c4c"   // Medium red
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 17

    // Clock
    Text{
        id: clock
        color: root.colRed
        font{family: root.fontFamily; pixelSize: root.fontSize; bold: true}
        text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")

        Timer{
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm:ss")
        }
    }
}
