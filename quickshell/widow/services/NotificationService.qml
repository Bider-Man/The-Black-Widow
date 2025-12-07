// Import Modules
pragma Singleton
import QtQuick

// Main Config
QtObject{
    id: root

    // Public API: Accessible globally
    signal notificationAdded(var notification)
    signal notificationRemoved(string notificationId)

    // Properties
    property list<QtObject> activeNotifications: []
    property int maxNotifications: 5
    property int defaultDuration: 5000

    // Function to send notifications so it can be called from anywhere
    function sendNotification(appName, summary, body, duration, properties){
        const notificationId = generateId()
        const notification = Qt.createQmlObject('
            import QtQuick
            QtObject{
                property string id: "${notificationId}"
                property string appName: "${appName}"
                property string summary: "${summary}"
                property string body: "${body}"
                property int duration: ${duration || root.defaultDuration}
                property var properties: ${JSON.stringify(properties || {})}
                property date timestamp: new Date()
                property bool expired: false
            }
        ', root)

        // Notification limits
        if (activeNotifications.length >= maxNotifications){
            removeNotification(activeNotifications[0].id)
        }

        activeNotifications.push(notification)
        notificationAdded(notification)

        // Auto-remove after duration
        if (notification.duration > 0){
            setTimeout(() => {
                removeNotification(notificationId)
            }, notification.duration)
        }

        return notificationId
    }

    // Remove Notification by ID
    function removeNotification(notificationId){
        for (let i = 0; i < activeNotifications.length; i++){
            if (activeNotifications[i].id === notificationId){
                const removed = activeNotifications.splice(i, 1)[0]
                removed.expired = true
                notificationRemoved(notificationId)
                break
            }
        }
    }

    // Clear all notifications
    function clearAll(){
        while (activeNotifications.length > 0){
            const notification = activeNotifications.shift()
            notification.expired = true
            notificationRemoved(notification.id)
        }
    }

    // Get notification by ID
    function getNotification(notificationID){
        return activeNotifications.find(n => n.id === notificationId) || null
    }

    // Private helper
    function generateId(){
        return Date.now().toString(36) + Math.random().toString(36).substr(2)
    }

    function setTimeout(callback, ms){
        const timer = Qt.createQmlObject('
            import QtQuick
            Timer{
                interval: ${ms}
                running: true
                repeat: false
                onTriggered: {
                    (${callback.toString()})();
                    destroy();
                }
            }
        ', root)
        return timer
    }
}
