// Import Modules
import qs.services
import QtQuick
import Quickshell.Services.Notifications

// Main Config
RippleButton{
    id: button
    property string buttonText
    property string urgency

    implicitHeight: 34
    leftPadding: 15
    rightPadding: 15
    buttonRadius: 5
    // Themed colours here colBackground:

    contentItem: StyledText{
        horizontalAlignment: Text.AlignHCenter
        text: buttonText
        // Themed colours color: 
    }
}
