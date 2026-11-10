import QtQuick
import qs.config
import qs.services

Rectangle {
	height: 30
	width: 15
	color: Colors.overlay
	//radius: 5

	Text {
		width: parent.width
		anchors.top: parent.top
		anchors.topMargin: 1
		font.pixelSize: 8
		font.family: "sans-serif"
		horizontalAlignment: Text.AlignHCenter
		color: Colors.text
		text: Time.time
	}
}

