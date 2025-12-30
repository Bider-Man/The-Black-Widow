// JavaScript module for theme configuration
const Theme = {
    // Colors
    panelBackground: "#2E3440",
    panelBorder: "#4C566A",
    notificationBackground: "transparent",
    textAppName: "#88C0D0",
    textSummary: "#ECEFF4",
    textBody: "#D8DEE9",
    textClose: "#81A1C1",
    textNoNotifications: "#81A1C1",
    actionButtonBg: "#4C566A",
    actionButtonText: "#ECEFF4",
    shadowColor: "#40000000",
    
    // Layout
    panelWidth: 350,
    panelCornerRadius: 8,
    panelBorderWidth: 1,
    itemCornerRadius: 8,
    itemVerticalPadding: 10,
    itemHorizontalPadding: 15,
    spacingBetweenItems: 10,
    spacingWithinItem: 5,
    closeButtonSize: 14,
    actionButtonHeight: 24,
    actionButtonPadding: 12,
    
    // Text
    fontSizeAppName: 9,
    fontSizeSummary: 10,
    fontSizeBody: 9,
    fontSizeAction: 8,
    fontSizeClose: 14,
    
    // Positioning
    panelTopMargin: 30,
    panelRightMargin: 30,
    
    // Animation
    notificationDuration: 5000,
    
    // Shadow
    shadowRadius: 8,
    shadowSamples: 17
}

// Export the theme
Qt.include("NotificationTheme.js")
