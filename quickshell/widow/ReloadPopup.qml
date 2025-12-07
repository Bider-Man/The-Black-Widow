// Import Modules
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland

// Main Config
Scope {
    id: root
    
    // State properties
    property bool failed: false
    property string errorString: ""
    property bool showPopup: false
    
    // Timing properties
    property int successDuration: 1000
    property int errorDuration: 10000
    property int popupDuration: failed ? errorDuration : successDuration
    
    // Color properties
    property color successBg: "#ffD1E8D5"
    property color successText: "#ff0C1F13"
    property color successBar: successText
    property color successBarBg: "#4027643e"
    
    property color errorBg: "#ffe99195"
    property color errorText: "#ff93000A"
    property color errorBar: errorText
    property color errorBarBg: "#30af1b25"
    
    // Layout properties
    property int horizontalPadding: 15
    property int verticalPadding: 15
    property int barHeight: 5
    property int barMargin: 10
    property int borderRadius: 12
    property int shadowRadius: 8
    
    // Font properties
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int titleFontSize: 14
    property int messageFontSize: 11
    
    // Connect to the Quickshell global to listen for the reload signals.
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
        
        // Position at top center
        anchors.top: true
        width: rect.width + shadow.radius * 2
        height: rect.height + shadow.radius * 2
        margins.top: 30 // Add some margin from top

        WlrLayershell.namespace: "quickshell:reloadPopup"
        WlrLayershell.layer: WlrLayershell.Layer.Top
        WlrLayershell.anchors: Anchor.Top | Anchor.Horizontal
        color: "transparent"

        Rectangle {
            id: rect
            anchors.centerIn: parent
            color: root.failed ? errorBg : successBg
            width: layout.width + horizontalPadding * 2
            height: layout.height + verticalPadding * 2 + (barBg.visible ? barMargin + barHeight : 0)
            radius: borderRadius

            // Makes the mouse area track mouse hovering
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

            // Progress bar background
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

            // Animated progress bar
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
