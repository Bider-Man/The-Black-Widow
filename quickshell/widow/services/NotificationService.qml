import QtQuick
import Quickshell
import Quickshell.Services.Notifications

// Singleton or globally accessible service
QtObject {
    id: root

    // The Quickshell notification server
    property var server: NotificationServer {
        id: notificationServer

        // Triggered for every new notification
        onNotification: function(notification) {
            console.log("Notification from:", notification.appName);
            // You can add filtering logic here
            // Emit a signal to update the UI
            root.newNotificationArrived(notification);
        }
    }

    // A signal to communicate with the display
    signal newNotificationArrived(var notification)

    // Function to manually close a notification
    function closeNotification(notificationId) {
        // Logic to find and dismiss the notification via the server
        // This is an example; the exact method depends on the notification object
        console.log("Closing notification:", notificationId);
    }
}
