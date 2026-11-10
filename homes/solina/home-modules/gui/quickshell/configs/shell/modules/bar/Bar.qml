import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.modules.widgets.vertical

Variants { 
	model: Quickshell.screens 

	Scope {
		required property var modelData

		PanelWindow {
			id: verticalBar
			screen: modelData
			readonly property double scale: screen.height / 1080
			aboveWindows: true

			anchors {
				top: true
				left: true
				bottom: true
			}
			margins {
				top: 6 * scale
				left: 6 * scale
				bottom: 6 * scale
			}

			implicitWidth: 40 * scale
			color: "transparent"

			Rectangle {
				//radius: 99999
				anchors.fill: parent
				color: Colors.base
				border.width: 2
				border.color: Colors.border

				Item {
					width: parent.width / (verticalBar.scale * 2)
					height: parent.height / (verticalBar.scale * 2)

					transform: Scale {
						xScale: verticalBar.scale * 2
						yScale: verticalBar.scale * 2
					}

					ColumnLayout {
						anchors.fill: parent
						anchors.leftMargin: -0.5
						anchors.topMargin: 6
						anchors.bottomMargin: 6
						width: parent.width
						spacing: 6
						
						SystemTray {
							Layout.alignment: Qt.AlignHCenter
							parentWindow: verticalBar
						}

						Item {
							Layout.fillHeight: true
						}


						Volume {
							Layout.alignment: Qt.AlignHCenter
						}

						SystemMonitor {
							Layout.alignment: Qt.AlignHCenter
						}

						Battery {
							Layout.alignment: Qt.AlignHCenter
						}

						Clock {
							Layout.alignment: Qt.AlignHCenter
						}
					}
				}
			}
		}
	}
}

