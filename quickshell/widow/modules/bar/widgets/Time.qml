// Import Modules
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

// Main Config
Singleton {
    id: root
    property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
