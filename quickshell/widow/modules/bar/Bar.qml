// Import Modules
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common
import qs.modules.bar.widgets

// Main Config for the Bar
Scope{
    id: bar

    Variants{
        model: Quickshell.screens

        PanelWindow{
            id: panel
            required property var modelData
            screen: modelData
            implicitHeight: 30
            implicitWidth: screen.width

            color: "gray"

            anchors{
                top: true
                left: true
                right: true
            }

            LeftBar{
                anchors{
                    top: parent.top
                    topMargin: qs.modules.common.Config.bar.topMargin
                    left: parent.left
                    LeftMargin: Config.bar.sideMargin
                }
            }
            
            MidBar{
                anchors{
                    top: parent.top
                    topMargin: qs.modules.common.Config.bar.topMargin
                    horizontalCenter: parent.horizontalCenter
                }
            }

            RightBar{
                anchors{
                    top: parent.top
                    topMargin: qs.modules.common.Config.bar.topMargin
                    right:  parent.right
                    rightMargin: Config.bar.sideMargin
                }
            }
        }
    }
}
