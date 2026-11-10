import QtQuick
import qs.config
import qs.services

Rectangle {
	height: 10
	width: 15
	color: Colors.overlay
	//radius: 5

	Text {
		width: parent.width
		anchors.top: parent.top
		anchors.topMargin: 1
		font.pixelSize: 7
		font.family: "sans-serif"
		horizontalAlignment: Text.AlignHCenter
		color: Colors.text
		text: `${Math.round(Battery.percent * 100)}%`
	}
}

