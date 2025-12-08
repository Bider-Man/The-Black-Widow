// Import Modules
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

// Main Config
Item {
    id: batteryCircle
    
    // =========== CONFIGURATION CONSTANTS ===========
    
    // Layout properties
    readonly property int _size: 30
    readonly property int _lineWidth: 3
    readonly property int _outerRadius: (_size / 2) - _lineWidth
    readonly property int _indicatorRadius: 2
    
    // Color palette
    readonly property color _colorNoBattery: "#444b6a"   // Gray
    readonly property color _colorCharging: "#0db9d7"    // Cyan
    readonly property color _colorHigh: "#9ece6a"        // Green (>60%)
    readonly property color _colorMedium: "#e0af68"      // Yellow (20-60%)
    readonly property color _colorLow: "#c84c4c"         // Red (<20%)
    readonly property color _colorBackground: "#444b6a"  // Circle background
    
    // Text properties
    readonly property string _fontFamily: "JetBrainsMono Nerd Font"
    readonly property int _fontSize: 10
    
    // Paths for system files (configurable per system)
    readonly property string _acOnlinePath: "/sys/class/power_supply/AC/online"
    readonly property string _capacityPath: "/sys/class/power_supply/BAT*/capacity"
    readonly property string _statusPath: "/sys/class/power_supply/BAT*/status"
    
    // Update interval in milliseconds
    readonly property int _updateInterval: 2000
    
    // =========== STATE PROPERTIES ===========
    
    implicitWidth: _size
    implicitHeight: _size
    Layout.alignment: Qt.AlignVCenter
    
    property real percentage: 0
    property bool charging: false
    property bool acConnected: false
    
    // =========== COLOR CALCULATION ===========
    
    readonly property color circleColor: {
        if (percentage === 0) return _colorNoBattery
        
        if (charging || (acConnected && percentage >= 95)) {
            return _colorCharging
        }
        
        if (percentage > 60) return _colorHigh
        if (percentage > 20) return _colorMedium
        return _colorLow
    }
    
    readonly property string displayText: percentage > 0 ? 
        Math.round(percentage) + "%" : "N/A"
    
    // =========== SYSTEM DATA FETCHING ===========
    
    Process {
        id: acProc
        command: ["sh", "-c", `cat ${_acOnlinePath} 2>/dev/null || echo 0`]
        stdout: SplitParser {
            onRead: data => acConnected = (data && data.trim() === "1")
        }
    }
    
    Process {
        id: batProc
        command: ["sh", "-c", `cat ${_capacityPath} 2>/dev/null | head -1`]
        stdout: SplitParser {
            onRead: function(data) {
                if (data) {
                    var pct = parseInt(data.trim())
                    if (!isNaN(pct)) percentage = pct
                }
            }
        }
    }
    
    Process {
        id: statusProc
        command: ["sh", "-c", `cat ${_statusPath} 2>/dev/null | head -1`]
        stdout: SplitParser {
            onRead: function(data) {
                if (data) {
                    var status = data.trim().toLowerCase()
                    charging = (status === "charging" || status === "full")
                }
            }
        }
    }
    
    Timer {
        interval: _updateInterval
        running: true
        repeat: true
        onTriggered: {
            acProc.running = true
            batProc.running = true
            statusProc.running = true
        }
    }
    
    // =========== CANVAS DRAWING ===========
    
    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        
        onPaint: {
            var ctx = getContext("2d")
            var centerX = width / 2
            var centerY = height / 2
            
            clearCanvas(ctx)
            drawBackgroundCircle(ctx, centerX, centerY)
            
            if (percentage > 0) {
                drawBatteryArc(ctx, centerX, centerY)
            }
            
            if (charging) {
                drawChargingIndicator(ctx, centerX, centerY)
            }
        }
        
        // Helper function: Clear the canvas
        function clearCanvas(ctx) {
            ctx.clearRect(0, 0, canvas.width, canvas.height)
        }
        
        // Helper function: Draw background circle
        function drawBackgroundCircle(ctx, centerX, centerY) {
            ctx.beginPath()
            ctx.arc(centerX, centerY, _outerRadius, 0, Math.PI * 2)
            ctx.fillStyle = _colorBackground
            ctx.fill()
        }
        
        // Helper function: Draw battery arc
        function drawBatteryArc(ctx, centerX, centerY) {
            var startAngle = -Math.PI / 2  // Start at top
            var endAngle = startAngle + (percentage / 100) * Math.PI * 2
            
            ctx.beginPath()
            ctx.moveTo(centerX, centerY)
            ctx.arc(centerX, centerY, _outerRadius, startAngle, endAngle)
            ctx.closePath()
            ctx.fillStyle = circleColor
            ctx.fill()
        }
        
        // Helper function: Draw charging indicator
        function drawChargingIndicator(ctx, centerX, centerY) {
            ctx.beginPath()
            ctx.arc(centerX, centerY, _indicatorRadius, 0, Math.PI * 2)
            ctx.fillStyle = _colorCharging
            ctx.fill()
        }
    }
    
    // =========== PERCENTAGE TEXT ===========
    
    Text {
        anchors.centerIn: parent
        text: displayText
        color: circleColor
        font { 
            family: _fontFamily
            pixelSize: _fontSize
            bold: true 
        }
    }
}
