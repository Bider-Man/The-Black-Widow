// Import Modules
pragma Singleton

import Quickshell
import QtQuick

// Main Config
Singleton{
    // Read Only Properties
    readonly property int mediaUpdateInterval: 500
    readonly property int visualiserBars: 45
    readonly property Sizes sizes: Sizes{}

    // Sizes Config
    component Sizes: QtObject{
        readonly property int tabIndicatorHeight: 3
        readonly property int tabIndicatorSpacing: 5
        readonly property int infoWidth: 200
        readonly property int infoIconSize: 25
        readonly property int dateTimeWidth: 110
        readonly property int mediaWidth: 200
        readonly property int mediaProgressSweep: 180
        readonly property int mediaProgressThickness: 8
        readonly property int resourceProgressThickness: 10
        readonly property int weatherWidth: 250
        readonly property int mediaCoverArtSize: 150
        readonly property int mediaVisualiserSize: 80
        readonly property int resourceSize: 200
    }
}
