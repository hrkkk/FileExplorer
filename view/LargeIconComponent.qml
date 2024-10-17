import QtQuick

Item {
    property string imageSource: ""
    property string fileName: ""
    property string fileType: ""

    signal itemDoubleClicked(string itemFileName, string itemFileType)
    signal itemRightClicked(string itemFileName)

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.fill: parent
            spacing: 5

            Image {
                id: thumbnail
                source: imageSource
                width: parent.width
                height: parent.height - 40
                fillMode: Image.PreserveAspectFit
            }

            Text {
                width: 160
                height: 30
                wrapMode: Text.WrapAnywhere
                text: fileName
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onEntered: {
                parent.color = "#797277"
            }

            onExited: {
                parent.color = "transparent"
            }

            onDoubleClicked: {
                itemDoubleClicked(fileName, fileType)
            }

            onClicked: {
                if (mouse.button === Qt.RightButton) {
                    itemRightClicked(fileName)
                }
            }
        }
    }
}
