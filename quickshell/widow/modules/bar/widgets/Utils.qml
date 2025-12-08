// Import Modules
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.common as Common

// Main Config
RowLayout {
    id: root
    spacing: 10

    // Use theme colors instead of hardcoded values
    readonly property color colBg: Common.Appearance.colors.colLayer0
    readonly property color colFg: Common.Appearance.colors.colOnLayer0
    readonly property color colMuted: Common.Appearance.colors.colOutlineVariant
    readonly property color colCpu: Common.Appearance.m3colors.m3secondary  // Brown for CPU
    readonly property color colMemory: Common.Appearance.m3colors.m3primary  // Red for memory
    readonly property string fontFamily: Common.Appearance.font.family.main
    readonly property int fontSize: Common.Appearance.font.pixelSize.smaller

    // System Properties Data
    property int memUsage: 0
    property int cpuUsage: 0
    property int swaUsage: 0
    property int memUsed: 0
    property int memTotal: 0
    property int swaUsed: 0
    property int swaTotal: 0
    property int lastCpuIdle: 0
    property int lastCpuTotal: 0

    // CPU Info
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -n 1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                
                // Get idle time
                var idle = parseInt(parts[4]) + parseInt(parts[5])
                
                // Calculate total CPU time (sum of all fields except "cpu")
                var total = 0
                for (var i = 1; i < parts.length; i++) {
                    total += parseInt(parts[i])
                }

                // Calculate usage percentage
                if (root.lastCpuTotal > 0) {
                    var idleDiff = idle - root.lastCpuIdle
                    var totalDiff = total - root.lastCpuTotal
                    
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(100 * (1 - idleDiff / totalDiff))
                    }
                }

                root.lastCpuTotal = total
                root.lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    // Memory Info
    Process {
        id: memProc
        command: ["sh", "-c", "free --kilo | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                
                // parts[1] = total, parts[2] = used, parts[6] = available
                root.memTotal = parseInt(parts[1])
                root.memUsed = parseInt(parts[2])
                
                if (root.memTotal > 0) {
                    memUsage = Math.round(100 * root.memUsed / root.memTotal)
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Swap Info
    Process {
        id: swaProc
        command: ["sh", "-c", "free --kilo | grep Swap"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                
                // parts[1] = total, parts[2] = used
                root.swaTotal = parseInt(parts[1])
                root.swaUsed = parseInt(parts[2])
                
                if (root.swaTotal > 0) {
                    swaUsage = Math.round(100 * root.swaUsed / root.swaTotal)
                } else {
                    swaUsage = 0  // No swap configured
                }
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            swaProc.running = true
        }
    }

    // Separator before CPU
    Rectangle { 
        width: 1
        height: 16
        color: colMuted 
        Layout.alignment: Qt.AlignVCenter
    }

    // Display components
    Text {
        text: "CPU: " + cpuUsage + "%"
        color: colCpu
        font { 
            family: fontFamily
            pixelSize: fontSize
            bold: true 
        }
        Layout.alignment: Qt.AlignVCenter
    }

    Rectangle { 
        width: 1
        height: 16
        color: colMuted 
        Layout.alignment: Qt.AlignVCenter
    }
    
    Text {
        text: "Mem: " + memUsage + "%"
        color: colMemory
        font { 
            family: fontFamily
            pixelSize: fontSize
            bold: true 
        }
        Layout.alignment: Qt.AlignVCenter
    }

    Rectangle { 
        width: 1
        height: 16
        color: colMuted 
        Layout.alignment: Qt.AlignVCenter
    }

    Text {
        text: "Swap: " + swaUsage + "%"
        color: colMemory
        font { 
            family: fontFamily
            pixelSize: fontSize
            bold: true 
        }
        Layout.alignment: Qt.AlignVCenter
    }
}
