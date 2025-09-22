// Import Modules
pragma Singleton

import Quickshell
import QtQuick

// Main Config
Singleton{
    // Read Only Properties
    readonly property int dragThreshold: 30
    readonly property Sizes sizes: Sizes{}

    // Sizes Config
    component Sizes: QtObject{
        readonly property int button: 80
    }
}
