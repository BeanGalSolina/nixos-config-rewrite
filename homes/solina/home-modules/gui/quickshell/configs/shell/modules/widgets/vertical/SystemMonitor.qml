import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

ColumnLayout {
	height: 155
	width: parent.width
	spacing: 1

	Rectangle {
		id: storage
		Layout.alignment: Qt.AlignHCenter
		//radius: 10
		height: 75
		width: 7
		color: Colors.overlay
		clip: true

		Text {
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottomMargin: 2
			text: `\uf0a0`
			font.pixelSize: 6
			color: Colors.text
		}

		Rectangle {
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottomMargin: 10
			color: Colors.text
			width: parent.width
			height: 2
		}

		Rectangle {
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottomMargin: 12
			color: Colors.darkAccent
			width: parent.width
			//topLeftRadius: 10
			//topRightRadius: 10
			height: SystemUsage.storageUsagePercent * 65

			Text {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: (width - height) / 2 + 2
				font.pixelSize: 6
				rotation: -90
				text: SystemUsage.storageUsage;
				color: Colors.text
			}
		}
	}

	RowLayout {
		Layout.alignment: Qt.AlignHCenter
		spacing: 1
		Rectangle {
			id: mem
			Layout.alignment: Qt.AlignHCenter
			//radius: 10
			height: 75
			width: 7
			color: Colors.overlay
			clip: true

			Text {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 2
				text: `\uefc5`
				font.pixelSize: 6
				color: Colors.text
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 10
				color: Colors.text
				width: parent.width
				height: 2
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 12
				color: Colors.darkAccent
				width: parent.width
				//topLeftRadius: 10
				//topRightRadius: 10
				height: SystemUsage.memoryUsagePercent * 65

				Text {
					anchors.bottom: parent.bottom
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.horizontalCenterOffset: -1
					anchors.bottomMargin: (width - height) / 2 + 2
					font.pixelSize: 6
					rotation: -90
					text: SystemUsage.memoryUsage;
					color: Colors.text
				}
			}
		}

		Rectangle {
			id: cpu
			Layout.alignment: Qt.AlignHCenter
			//radius: 10
			height: 75
			width: 7
			color: Colors.overlay
			clip: true

			Text {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 2
				text: `\uf4bc`
				font.pixelSize: 6
				leftPadding: -0.2
				color: Colors.text
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.bottomMargin: 10
				color: Colors.text
				width: parent.width
				height: 2
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.horizontalCenterOffset: -1
				anchors.bottomMargin: 12
				color: Colors.darkAccent
				width: parent.width
				//topLeftRadius: 10
				//topRightRadius: 10
				height: SystemUsage.cpuPerformance * 65

				Text {
					anchors.bottom: parent.bottom
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.bottomMargin: (width - height) / 2 + 2
					font.pixelSize: 6
					rotation: -90
					text: `${Math.round(SystemUsage.cpuPerformance * 100)}%`;
					color: Colors.text
				}
			}
		}
	}
}
