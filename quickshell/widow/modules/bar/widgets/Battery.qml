import QtQuick
import Quickshell.Services.UPower
import qs.modules.common

Rectangle {
  id: container
  implicitHeight: contentRow.implicitHeight
  // 51 is the largest with of the icons, the balanced icon
  implicitWidth: 50
  color: "transparent"
  //border.color: "red"
  //border.width: 1
  anchors.right: parent.right

  function cycleIcons(): string {
    switch (UPower.displayDevice.state) {
      case UPowerDeviceState.Unknown: return "?"
      case UPowerDeviceState.Charging: return "Charging"
      case UPowerDeviceState.Discharging: return "Discharging"
      case UPowerDeviceState.Empty: return "Empty"
      case UPowerDeviceState.FullyCharged: return "Fully Charged"
    }
  }

  Row {
    id: contentRow
    spacing: 0
    anchors.verticalCenter: parent.verticalCenter
    
    Text { text: UPower.displayDevice.percentage * 100 + "%" }
  }
}
