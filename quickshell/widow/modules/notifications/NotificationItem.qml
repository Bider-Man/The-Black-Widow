import QtQuick
import QtQuick.Layouts
import "./NotificationTheme.js" as Theme  // Import theme

Rectangle {
    id: notificationRoot
    
    // Required property - passed from parent
    required property var notificationData
    property var theme: Theme  // Expose theme to parent if needed
    
    // Visual properties
    width: parent ? parent.width : Theme.panelWidth - 40
    implicitHeight: contentLayout.implicitHeight + (Theme.itemVerticalPadding * 2)
    color: Theme.notificationBackground
    radius: Theme.itemCornerRadius
    
    // Signal for parent
    signal closed()
    signal actionTriggered(string actionId)
    
    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.margins: Theme.itemHorizontalPadding
        spacing: Theme.spacingWithinItem
        
        // Header row with app name and close button
        RowLayout {
            Layout.fillWidth: true
            
            // Application name
            Text {
                id: appNameText
                text: notificationData.appName
                color: Theme.textAppName
                font.bold: true
                font.pixelSize: Theme.fontSizeAppName
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
            
            // Close button
            Text {
                text: "×"
                color: Theme.textClose
                font.pixelSize: Theme.fontSizeClose
                font.bold: true
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: notificationRoot.closed()
                }
            }
        }
        
        // Notification summary
        Text {
            id: summaryText
            text: notificationData.summary
            color: Theme.textSummary
            font.bold: true
            font.pixelSize: Theme.fontSizeSummary
            wrapMode: Text.Wrap
            Layout.fillWidth: true
            visible: text !== ""
        }
        
        // Notification body
        Text {
            id: bodyText
            text: notificationData.body
            color: Theme.textBody
            font.pixelSize: Theme.fontSizeBody
            wrapMode: Text.Wrap
            Layout.fillWidth: true
            visible: text !== ""
        }
        
        // Actions (if available)
        RowLayout {
            spacing: Theme.spacingWithinItem
            visible: notificationData.actions && notificationData.actions.length > 0
            Layout.topMargin: Theme.spacingWithinItem
            
            Repeater {
                model: notificationData.actions
                
                Rectangle {
                    color: Theme.actionButtonBg
                    radius: 4
                    height: Theme.actionButtonHeight
                    implicitWidth: actionText.implicitWidth + Theme.actionButtonPadding
                    
                    Text {
                        id: actionText
                        text: modelData.label
                        color: Theme.actionButtonText
                        font.pixelSize: Theme.fontSizeAction
                        anchors.centerIn: parent
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notificationRoot.actionTriggered(modelData.id)
                    }
                }
            }
        }
    }
}
