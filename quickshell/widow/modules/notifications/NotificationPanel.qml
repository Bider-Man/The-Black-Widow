import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import Qt5Compat.GraphicalEffects
import "./NotificationTheme.js" as Theme

PanelWindow {
    id: notificationPanel
    
    // Configuration
    property var notificationServer: null  // Set from parent
    property var theme: Theme
    
    // Window properties
    visible: false
    exclusiveZone: 0
    color: "transparent"
    
    // Position at top-right
    anchors.right: true
    anchors.top: true
    margins.top: Theme.panelTopMargin
    margins.right: Theme.panelRightMargin
    
    // Size based on content
    width: Theme.panelWidth
    height: contentColumn.implicitHeight + (Theme.itemVerticalPadding * 2)
    
    // Wayland configuration
    WlrLayershell.namespace: "quickshell:notifications"
    WlrLayershell.layer: WlrLayershell.Layer.Top
    WlrLayershell.anchors: Anchor.Top | Anchor.Right
    
    // Background container
    Rectangle {
        id: panelBackground
        anchors.fill: parent
        color: Theme.panelBackground
        radius: Theme.panelCornerRadius
        border.color: Theme.panelBorder
        border.width: Theme.panelBorderWidth
        
        // Shadow effect
        layer.enabled: true
        layer.effect: DropShadow {
            color: Theme.shadowColor
            radius: Theme.shadowRadius
            samples: Theme.shadowSamples
            transparentBorder: true
        }
        
        // Notification list
        Column {
            id: contentColumn
            width: parent.width - (Theme.itemHorizontalPadding * 2)
            anchors.centerIn: parent
            spacing: Theme.spacingBetweenItems
            
            // Display all notifications
            Repeater {
                model: notificationServer ? notificationServer.trackedNotifications : []
                
                delegate: NotificationItem {
                    width: contentColumn.width
                    notificationData: modelData
                    
                    onClosed: function() {
                        if (modelData.dismiss) {
                            modelData.dismiss()
                        }
                    }
                    
                    onActionTriggered: function(actionId) {
                        console.log("Action triggered:", actionId, "for app:", modelData.appName)
                        if (modelData.invokeAction) {
                            modelData.invokeAction(actionId)
                        }
                    }
                }
            }
            
            // Empty state
            Text {
                text: "No notifications"
                color: Theme.textNoNotifications
                font.italic: true
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !notificationServer || notificationServer.trackedNotifications.count === 0
            }
        }
    }
    
    // Update panel visibility when notifications change
    function updateVisibility() {
        notificationPanel.visible = notificationServer && 
                                   notificationServer.trackedNotifications.count > 0
    }
    
    // Connect to notification server changes
    Connections {
        target: notificationServer
        enabled: notificationServer !== null
        
        function onNotification() {
            updateVisibility()
        }
        
        function onTrackedNotificationsChanged() {
            updateVisibility()
        }
    }
    
    // Initialize
    Component.onCompleted: {
        if (notificationServer) {
            updateVisibility()
        }
    }
}
