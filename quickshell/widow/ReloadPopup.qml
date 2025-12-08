// Import Modules
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import qs.common as Common

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
    
    // Use theme colors
    readonly property color successBg: Common.Appearance.colors.colSuccessContainer
    readonly property color successText: Common.Appearance.colors.colOnSuccessContainer
    readonly property color successBar: successText
    readonly property color successBarBg: Common.Appearance.colors.colOutlineVariant
    
    readonly property color errorBg: Common.Appearance.colors.colErrorContainer
    readonly property color errorText: Common.Appearance.colors.colOnErrorContainer
    readonly property color errorBar: errorText
    readonly property color errorBarBg: Common.Appearance.colors.colOutlineVariant
    
    // Layout properties
    readonly property int horizontalPadding: 15
    readonly property int verticalPadding: 15
    readonly property int barHeight: 5
    readonly property int barMargin: 10
    readonly property int borderRadius: Common.Appearance.rounding.small
    readonly property int shadowRadius: 8
    
    // Font properties
    readonly property string fontFamily: Common.Appearance.font.family.main
    readonly property int titleFontSize: Common.Appearance.font.pixelSize.small
    readonly property int messageFontSize: Common.Appearance.font.pixelSize.smaller

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
        implicitWidth: rect.width + shadow.radius * 2
        implicitHeight: rect.height + shadow.radius * 2
        margins.top: 30

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
            color: Common.Appearance.colors.colShadow
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
