// Import Modules
pragma Singleton

import Quickshell
import QtQuick

// Main Config
Singleton{
    // Read Only Properties
    readonly property int maxShown: 0
    readonly property int maxWallpapers: 10
    readonly property string actionPrefix: ">>"
    readonly property Sizes sizes: Sizes{}

    // Sizes Config
    component Sizes: QtObject{
        readonly property int itemWidth: 600
        readonly property int itemHeight: 60
        readonly property int wallpaperWidth: 280
        readonly property int wallpaperHeight: 200
    }
}
