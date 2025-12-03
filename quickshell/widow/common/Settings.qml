// Settings.qml for Black Widow
import QtQuick

QtObject{
    id: root

    // Load the config file (json)
    property var configData:{
        try{
            const xhr = new XMLHttpRequest();
            xhr.open("GET", Qt.resolvedUrl("../config.json"), false);
            xhr.send();
            return JSON.parse(xhr.responseText);
        } catch(e) {
            console.error("Failed to load config.json: ", e);
            return{};
        }
    }

    // Theme Colors
    readonly property var colors: configData.theme?.colors || {}
    readonly property string background: colors.background || "#0a0a0a"
    readonly property string backgroundAlt: colors.backgroundAlt || "#1a1a1a"
    readonly property string surface: colors.surface || "#2a2a2a"
    readonly property string surfaceAlt: colors.surfaceAlt || "#3a3a3a"
    readonly property string primary: colors.primary || "#dc2626"
    readonly property string primaryDark: colors.primaryDark || "#991b1b"
    readonly property string primaryLight: colors.primaryLight || "#ef4444"
    readonly property string accent: colors.accent || "#b91c1c"
    readonly property string text: colors.text || "#f5f5f5"
    readonly property string textDim: colors.textDim || "#a3a3a3"
    readonly property string textDimmer: colors.textDimmer || "#737373"
    readonly property string border: colors.border || "#404040"
    readonly property string success: colors.success || "#22c55e"
    readonly property string warning: colors.warning || "#f59e0b"
    readonly property string error: colors.error || "#dc2626"
    readonly property string brown: colors.brown || "#78350f"
    readonly property string brownLight: colors.brownLight || "#92400e"
    readonly property string brownDark: colors.brownDark || "#451a03"

    // Font settings
    readonly property var fonts: configData.theme?.fonts || {}
    readonly property string fontMain: fonts.main || "JetBrainsMono Nerd Font"
    readonly property string fontIcons: fonts.icons || "JetBrainsMono Nerd Font"
    readonly property var fontSize: fonts.size || {}
    readonly property int fontSizeSmall: fontSize.small || 10
    readonly property int fontSizeNormal: fontSize.normal || 12
    readonly property int fontSizeLarge: fontSize.large || 14
    readonly property int fontSizeXLarge: fontSize.xlarge || 16

    // Spacing values
    readonly property var spacing: configData.theme?.spacing || {}
    readonly property int spacingSmall: spacing.small || 4
    readonly property int spacingMedium: spacing.medium || 8
    readonly property int spacingLarge: spacing.large || 12
    readonly property int spacingXLarge: spacing.xlarge || 16

    // Border radius values
    readonly property var radius: configData.theme?.radius || {}
    readonly property int radiusSmall: radius.small || 4
    readonly property int radiusMedium: radius.medium || 8
    readonly property int radiusLarge: radius.large || 12
    readonly property int radiusFull: radius.full || 9999

    // Opacity values
    readonly property var opacity: configData.theme?.opacity || {}
    readonly property real opacityDim: opacity.dim || 0.7
    readonly property real opacityDimmer: opacity.dimmer || 0.5
    readonly property real opacitySubtle: opacity.subtle || 0.3

    // Bar configuration
    readonly property var barConfig: configData.bar || {}
    readonly property int barHeight: barConfig.height || 32
    readonly property int barMargins: barConfig.margins || 8
    readonly property int barSpacing: barConfig.spacing || 8

    // Dock configuration
    readonly property var dockConfig: configData.dock || {}
    readonly property int dockIconSize: dockConfig.iconSize || 48
    readonly property int dockMargins: dockConfig.margins || 8
    readonly property int dockSpacing: dockConfig.spacing || 8

    // Panel configuration
    readonly property var panelConfig: configData.panel || {}
    readonly property int panelWidth: panelConfig.width || 420
    readonly property int panelMargins: panelConfig.margins || 8

    // OSD configuration
    readonly property var osdConfig: configData.osd || {}
    readonly property int osdTimeout: osdConfig.timeout || 2000
    readonly property int osdWidth: osdConfig.width || 300
}
