//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

// Adjust this to make the shell smaller or larger
//@ pragma Env QT_SCALE_FACTOR=1

import qs.modules.common
import qs.modules.widow.background
import qs.modules.widow.bar
import qs.modules.widow.cheatsheet
import qs.modules.widow.dock
import qs.modules.widow.lock
import qs.modules.widow.mediaControls
import qs.modules.widow.notificationPopup
import qs.modules.widow.onScreenDisplay
import qs.modules.widow.onScreenKeyboard
import qs.modules.widow.overview
import qs.modules.widow.polkit
import qs.modules.widow.regionSelector
import qs.modules.widow.screenCorners
import qs.modules.widow.sessionScreen
import qs.modules.widow.sidebarRight
import qs.modules.widow.overlay
import qs.modules.widow.verticalBar
import qs.modules.widow.wallpaperSelector

import QtQuick
import QtQuick.Window
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.services

ShellRoot {
    id: root

    // Force initialization of some singletons
    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme()
        Hyprsunset.load()
        FirstRunExperience.load()
        ConflictKiller.load()
        Cliphist.refresh()
        Wallpapers.load()
        Updates.load()
    }

    // Load enabled stuff
    // Well, these loaders only *allow* them to be loaded, to always load or not is defined in each component
    // The media controls for example is not loaded if it's not opened
    PanelLoader { identifier: "widowBar"; extraCondition: !Config.options.bar.vertical; component: Bar {} }
    PanelLoader { identifier: "widowBackground"; component: Background {} }
    PanelLoader { identifier: "widowCheatsheet"; component: Cheatsheet {} }
    PanelLoader { identifier: "widowDock"; extraCondition: Config.options.dock.enable; component: Dock {} }
    PanelLoader { identifier: "widowLock"; component: Lock {} }
    PanelLoader { identifier: "widowMediaControls"; component: MediaControls {} }
    PanelLoader { identifier: "widowNotificationPopup"; component: NotificationPopup {} }
    PanelLoader { identifier: "widowOnScreenDisplay"; component: OnScreenDisplay {} }
    PanelLoader { identifier: "widowOnScreenKeyboard"; component: OnScreenKeyboard {} }
    PanelLoader { identifier: "widowOverlay"; component: Overlay {} }
    PanelLoader { identifier: "widowOverview"; component: Overview {} }
    PanelLoader { identifier: "widowPolkit"; component: Polkit {} }
    PanelLoader { identifier: "widowRegionSelector"; component: RegionSelector {} }
    PanelLoader { identifier: "widowScreenCorners"; component: ScreenCorners {} }
    PanelLoader { identifier: "widowSessionScreen"; component: SessionScreen {} }
    PanelLoader { identifier: "widowSidebarRight"; component: SidebarRight {} }
    PanelLoader { identifier: "widowVerticalBar"; extraCondition: Config.options.bar.vertical; component: VerticalBar {} }
    PanelLoader { identifier: "widowWallpaperSelector"; component: WallpaperSelector {} }

    ReloadPopup {}

    component PanelLoader: LazyLoader {
        required property string identifier
        property bool extraCondition: true
        active: Config.ready && Config.options.enabledPanels.includes(identifier) && extraCondition
    }

    // Panel families
    property list<string> families: ["widow"]
    property var panelFamilies: ({
        "widow": ["widowBar", "widowBackground", "widowCheatsheet", "widowDock", "widowLock", "widowMediaControls", "widowNotificationPopup", "widowOnScreenDisplay", "widowOnScreenKeyboard", "widowOverlay", "widowOverview", "widowPolkit", "widowRegionSelector", "widowScreenCorners", "widowSessionScreen", "widowSidebarLeft", "widowSidebarRight", "widowVerticalBar", "widowWallpaperSelector"],
    })
    function cyclePanelFamily() {
        const currentIndex = families.indexOf(Config.options.panelFamily)
        const nextIndex = (currentIndex + 1) % families.length
        Config.options.panelFamily = families[nextIndex]
        Config.options.enabledPanels = panelFamilies[Config.options.panelFamily]
    }

    IpcHandler {
        target: "panelFamily"

        function cycle(): void {
            root.cyclePanelFamily()
        }
    }

    GlobalShortcut {
        name: "panelFamilyCycle"
        description: "Cycles panel family"

        onPressed: root.cyclePanelFamily()
    }
}

