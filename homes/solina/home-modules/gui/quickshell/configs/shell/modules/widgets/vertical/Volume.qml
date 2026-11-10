import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.config
import qs.services

Rectangle {
	readonly property var pwNode: Pipewire.defaultAudioSink ?? Pipewire.preferredDefaultAudioSink;

	PwObjectTracker {
		objects: [pwNode];
	}

	height: 80
	width: 13
	color: Colors.overlay
	//radiu: 999

	ColumnLayout {
		anchors.fill: parent
		anchors.topMargin: 3
		anchors.bottomMargin: 2
		spacing: 0

		MouseArea {
			Layout.fillHeight: true
			width: parent.width

			function updateVolume(mouseY) {
				let trackHeight = height - 7
				let val = Math.max(Math.min((height - mouseY - (3.5)) / trackHeight, 1), 0)
				pwNode.audio.volume = val * val * val
			}

			onPressed: (mouse) => updateVolume(mouse.y)
			onPositionChanged: (mouse) => updateVolume(mouse.y)

			Rectangle {
				anchors.top: parent.top
				anchors.topMargin: 3
				anchors.bottom: parent.bottom
				anchors.bottomMargin: 3
				anchors.horizontalCenter: parent.horizontalCenter
				//radiu: 999
				width: 3
				color: Colors.secondary_text
			}

			Rectangle {
				anchors.top: parent.top
				anchors.topMargin: {
					let height = parent.height - 7
					let val = Math.min(Math.max(pwNode?.audio.volume, 0), 1)
					return height - height * Math.pow(val, 1/3)
				}
				anchors.bottom: parent.bottom
				anchors.horizontalCenter: parent.horizontalCenter
				//radiu: 999
				width: 7
				color: Colors.accent
			}
		}

		Item {
			height: 2
		}
		
		Text {
			text: "\udb81\udd7e"
			font.pixelSize: 9
			Layout.alignment: Qt.AlignHCenter
			color: Colors.text
		}
	}
}


