// Import Modules
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

// Main Config

RowLayout{
    id: root

    // Theme 
    property color colBg: "#0a0a0a"       // Near-black
    property color colFg: "#f5f5f5"       // Off-white
    property color colMuted: "#4a4a4a"    // Dark gray
    property color colBrick: "#b22222"      // Firebrick red
    property color colRed: "#c84c4c"   // Medium red
    property color colBrown: "#996515"    // Dark brown
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    // System Properties Data
    property int memUsage: 0
    property int cpuUsage: 0
    property int swaUsage: 0
    property var swaUsed: 0
    property var swaTotal: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    // CPU Info
    Process{
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser{
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.splice(1, 8).reduce((a, b) => a + parseInt(b), 0)

                if (lastCpuTotal > 0){
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle)/(total - laastCpuTotal)))
                }

                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }

        Component.onCompleted: running = true
    }

    // Memory Info
    Process{
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser{
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var swaTotal = parseInt(parts[1]) || 1
                var swaUsed = parseInt(parts[2]) || 2
                memUsage = Math.round(100 * swaUsed / swaTotal)
            }
        }

        Component.onCompleted: running = true
    }

    // Swap Info
    Process{
        id: swaProc
        command: ["sh", "-c", "free | grep Swap"]
        stdout: SplitParser{
            onRead: data => {
                if (!data) return
                var swap = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 2
                swapUsage = Math.round(100 * used / total)
            }
        }

        Component.onCompleted: running = true
    }

    Timer{
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            swaProc.running = true
        }
    }

    // CPU Text
    Text{
        text: "CPU: " + cpuUsage + "%"
        color: root.colBrown
        font{family: root.fontFamily; pixelSize: root.fontSize; bold: true}
    }

    // Borders around the info
    Rectangle{ width: 1; height: 16; color: root.colMuted }
    
    // Memory
    Text{
        text: "Mem: " + memUsage + "%"
        color: root.colBrick
        font{family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }

    Rectangle { width: 1; height: 16; color: root.colMuted }

    // Memory
    Text{
        text: "Swap: " + swaUsage + "%"
        color: root.colBrick
        font{family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }
}
