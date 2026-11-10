import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

Variants { 
	model: Quickshell.screens 

	Scope {
		required property var modelData

		PanelWindow {
			id: window

			anchors.top: true
			anchors.right: true
			margins.top: 7 * window.scale
			margins.right: 7 * window.scale

			aboveWindows: true
			exclusionMode: ExclusionMode.Ignore
			color: "transparent"

			screen: modelData
			readonly property double scale: screen.height / 1080

			implicitWidth: wrapper.width
			implicitHeight: wrapper.height

			Item {
				id: wrapper
				transform: Scale {
					xScale: window.scale * 2
					yScale: window.scale * 2
				}

				width: 500
				height: childrenRect.height * window.scale * 2

				ColumnLayout {
					width: parent.width / (window.scale *  2)


					Repeater {
						model: NotifServer.notifications
						id: notif

						Rectangle {
							Component.onCompleted: modelData.tracked=true
							Layout.alignment: Qt.AlignHCenter
							Layout.preferredWidth: parent.width
							Layout.preferredHeight:	childrenRect.height
							color: Colors.base
							border.color: Colors.border
							border.width: 1
							//radius: 7

							ColumnLayout {
								width: parent.width
								height: modelData.actions[0] ? 55 : 40

								RowLayout {
									spacing: 3
									width: parent.width
									height: 40

									Item {width:3}

									Image {
										Layout.preferredWidth: 30
										Layout.preferredHeight: 30
										fillMode: Image.PreserveAspectFit
										smooth: true

										Layout.topMargin: 5

										source: modelData.image || Quickshell.iconPath(modelData.appIcon)
									}

									ColumnLayout {
										Layout.fillWidth: true
										spacing: 0

										Item {height: 3}

										RowLayout {
											Layout.fillWidth: true
											spacing: 5

											Text {
												Layout.fillWidth: true
												text: modelData.summary || modelData.appName || "Unknown"

												elide: Text.ElideRight
												maximumLineCount: 1
												color: Colors.text
												font.pixelSize: 11
												font.bold: true
											}

											MouseArea {
												hoverEnabled: true
												width: 11
												height: 11

												onClicked: {
													modelData.tracked = false
												}

												Rectangle {
													width: parent.height
													height: parent.height
													//radius: 5

													color: parent.containsMouse ? Colors.overlay : "transparent"

													Text {
														horizontalAlignment: Text.AlignCenter
														anchors.fill: parent
														topPadding: -1

														text: "\uf467"
														color: Colors.text
														font.pixelSize: 11
													}
												}
											}

											Item {}
										}

										Item {height: 1}

										Rectangle {
											height: 1
											//radius: 999
											Layout.fillWidth: true
											color: Colors.secondary_text
										}

										Item {height: 2}

										Text {
											Layout.fillHeight: true
											Layout.preferredWidth: 210

											text: modelData.body.replace(/\n{2,}/g, '\n') || "Unknown"
											maximumLineCount: 2
											wrapMode: Text.WordWrap

											color: Colors.text
											font.pixelSize: 7
											verticalAlignment: Text.AlignTop
										}
									}

									Item {width:1}
								}

								RowLayout {
									width: parent.width
									height: 15
									spacing: -0.5

									Repeater {
										id: actionRepeater
										model: modelData.actions

										MouseArea {
											Layout.fillWidth: true
											height: parent.height
											hoverEnabled: true

											onClicked: { modelData.invoke() }

											Rectangle {
												border.width: 1
												border.color: Colors.border
												color: parent.containsMouse ? Colors.overlay : Colors.base
												anchors.fill: parent

												//bottomLeftRadius: (index == 0) ? 7 : 0
												////bottomRightRadius: (index == actionRepeater.count - 1) ? 7 : 0

												Text {
													anchors.fill: parent
													maximumLineCount: 1
													elide: Text.ElideRight
													leftPadding: 3
													rightPadding: 3
													color: Colors.text
													font.pixelSize: 10
													font.bold: true

													verticalAlignment: Text.AlignVCenter
													horizontalAlignment: Text.AlignHCenter

													text: modelData.text
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

