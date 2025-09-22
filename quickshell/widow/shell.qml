// Credits go here //

// Import Modules and Files //
import "./modules/bar/"
import "./modules/cheatsheet/"
import "./modules/common/"
import "./modules/lockscreen/"
import "./modules/media/"
import "./modules/notification/"
import "./modules/osd/"
import "./modules/overview/"
import "./modules/session/"
import "./modules/settings/"
import "./modules/sidebarLeft/"
import "./modules/sidebarRight/"
import "./modules/wallpaper/"
import "./services/"
import QtQuick
import QtQuick.Window
import Quickshell

// Main Config //
ShellRoot{
    property bool enableBar: true
    property bool enableCheatsheet: true
    property bool enableCommon: true
    property bool enableLockscreen: true
    property bool enableMedia: true
    property bool enableNotification: true
    property bool enableOSD: true
    property bool enableOverview: true
    property bool enableSession: true
    property bool enableSettings: true
    property bool enableSidebarLeft: true
    property bool enableSidebarRight: true
    property bool enableWallpaper: true

    // Force init on singletons
    Component.onCompleted: {
        Hyprsunset.load()
        ConflictKiller.load()
        Cliphist.refresh()
        Wallpapers.load()
    }

    LazyLoader { active: enableBar && Config.ready && !Config.options.bar.vertical; component: Bar {} }
    LazyLoader { active: enableCheatsheet; component: Cheatsheet {} }
    LazyLoader { active: enableLock; component: Lockscreen {} }
    LazyLoader { active: enableMediaControls; component: Media {} }
    LazyLoader { active: enableNotificationPopup; component: Notification {} }
    LazyLoader { active: enableOnScreenKeyboard; component: OSD {} }
    LazyLoader { active: enableOverview; component: Overview {} }
    LazyLoader { active: enableSessionScreen; component: Session {} }
    LazyLoader { active: enableSidebarLeft; component: SidebarLeft {} }
    LazyLoader { active: enableSidebarRight; component: SidebarRight {} }
    LazyLoader { active: enableWallpaperSelector; component: Wallpaper {} }
}
