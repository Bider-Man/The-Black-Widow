pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root
    property QtObject options: QtObject {
        property QtObject appearance: QtObject {
            property QtObject transparency: QtObject {
                property bool enable: false
                property bool automatic: false
                property real backgroundTransparency: 0
                property real contentTransparency: 0
            }
            
            property QtObject fonts: QtObject {
                property string main: "JetBrainsMono Nerd Font"
                property string numbers: "JetBrainsMono Nerd Font"
                property string title: "JetBrainsMono Nerd Font"
                property string iconNerd: "JetBrainsMono Nerd Font"
                property string monospace: "JetBrainsMono Nerd Font"
                property string reading: "JetBrainsMono Nerd Font"
                property string expressive: "JetBrainsMono Nerd Font"
            }
            
            property bool extraBackgroundTint: false
        }
        
        property QtObject bar: QtObject {
            property int cornerStyle: 0  // 0: Hug, 1: Float, 2: Plain rectangle
            property bool verbose: true
        }
        
        property QtObject background: QtObject {
            property string wallpaperPath: ""
            property string thumbnailPath: ""
        }
    }
}
