import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland

Scope {
    id: root
    
    property bool failed: false
    property string errorString: ""
    property bool showPopup: false
    
    property int successDuration: 1000
    property int errorDuration: 10000
    property int popupDuration: failed ? errorDuration : successDuration
    
    // Hardcoded Black Widow colors
    readonly property color successBg: "#2c1a0a"        // Dark brown
    readonly property color successText: "#e6d5c3"      // Light cream
    readonly property color successBar: successText
    readonly property color successBarBg: "#4a433c"     // Dark brown
    
    readonly property color errorBg: "#410002"          // Very dark red
    readonly property color errorText: "#ffdad6"        // Light pink
    readonly property color errorBar: errorText
    readonly property color errorBarBg: "#4a433c"       // Dark brown
    
    readonly property int horizontalPadding: 15
    readonly property int verticalPadding: 15
    readonly property int barHeight: 5
    readonly property int barMargin: 10
    readonly property int borderRadius: 12
    readonly property int shadowRadius: 8
    
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int titleFontSize: 14
    readonly property int messageFontSize: 11

    Connections {
        target: Quickshell

        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
            root.failed = false;
            root.errorString = "";
            root.showPopup = true;
            hideTimer.restart();
        }

        function onReloadFailed(error: string) {
            Quickshell.inhibitReloadPopup();
            root.failed = true;
            root.errorString = error;
            root.showPopup = true;
            hideTimer.restart();
        }
    }

    PanelWindow {
        id: popupWindow
        visible: root.showPopup
        exclusiveZone: 0
        
        anchors.top: true
        implicitWidth: rect.width + shadow.radius * 2
        implicitHeight: rect.height + shadow.radius * 2
        margins.top: 30

        WlrLayershell.namespace: "quickshell:reloadPopup"
        WlrLayershell.layer: WlrLayershell.Layer.Top
        WlrLayershell.anchors: Quickshell.Wayland.WlrLayershell.Anchor.Top | Quickshell.Wayland.WlrLayershell.Anchor.Horizontal
        color: "transparent"

        Rectangle {
            id: rect
            anchors.centerIn: parent
            color: root.failed ? errorBg : successBg
            width: layout.width + horizontalPadding * 2
            height: layout.height + verticalPadding * 2 + (barBg.visible ? barMargin + barHeight : 0)
            radius: borderRadius

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.showPopup = false;
                    hideTimer.stop();
                }
            }

            ColumnLayout {
                id: layout
                spacing: 10
                anchors {
                    top: parent.top
                    topMargin: verticalPadding
                    horizontalCenter: parent.horizontalCenter
                }

                Text {
                    renderType: Text.NativeRendering
                    font.family: fontFamily
                    font.pointSize: titleFontSize
                    text: root.failed ? "Quickshell: Reload failed" : "Quickshell reloaded"
                    color: root.failed ? errorText : successText
                }

                Text {
                    id: errorText
                    renderType: Text.NativeRendering
                    font.family: fontFamily
                    font.pointSize: messageFontSize
                    text: root.errorString
                    color: root.failed ? errorText : successText
                    visible: root.errorString !== ""
                    Layout.maximumWidth: 400
                    wrapMode: Text.Wrap
                }
            }

            Rectangle {
                id: barBg
                anchors {
                    bottom: parent.bottom
                    bottomMargin: barMargin
                    horizontalCenter: parent.horizontalCenter
                }
                color: root.failed ? errorBarBg : successBarBg
                height: barHeight
                radius: 9999
                width: rect.width - barMargin * 2
                visible: root.showPopup
            }

            Rectangle {
                id: bar
                anchors {
                    bottom: parent.bottom
                    bottomMargin: barMargin
                    left: barBg.left
                }
                color: root.failed ? errorBar : successBar
                height: barHeight
                radius: 9999
                width: barBg.width
                
                PropertyAnimation {
                    id: barAnimation
                    target: bar
                    property: "width"
                    from: barBg.width
                    to: 0
                    duration: popupDuration
                    running: root.showPopup && !mouseArea.containsMouse
                    onFinished: {
                        root.showPopup = false;
                    }
                }
            }
        }

        DropShadow {
            id: shadow
            anchors.fill: rect
            horizontalOffset: 0
            verticalOffset: 2
            radius: shadowRadius
            samples: shadowRadius * 2 + 1
            color: "#40000000"
            source: rect
        }
    }

    Timer {
        id: hideTimer
        interval: popupDuration
        onTriggered: {
            root.showPopup = false;
        }
    }
}
