// Import Modules
pragma Singleton

import Quickshell
import QtQuick

// Main Config
Singleton{
    // Read Only Properties
    readonly property int hideDelay: 2000
    readonly property Sizes sizes: Sizes{}

    // Sizes Config
    component Sizes: QtObject{
        readonly property int sliderWidth: 30
        readonly property int sliderHeight: 150
    }
}
