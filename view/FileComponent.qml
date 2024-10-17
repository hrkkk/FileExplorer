import QtQuick

Rectangle {
    property string fileName: ""
    property string fileDate: ""
    property string fileType: ""
    property int fileSize: 0
    signal itemDoubleClicked(string itemFileName, string itemFileType)
    signal itemRightClicked(string itemFileName)

    width: parent.width
    height: 30
    color: "transparent"
    radius: 3

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

    Row {
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.leftMargin: 10
        spacing: 8

        Image {
            source: fileType === "DIR" ? "qrc:/resources/dir.png" : "qrc:/resources/file.png"
            width: 0.7 * parent.height
            height: 0.7 * parent.height
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: fileName
            width: 0.3 * parent.width
            height: parent.height
            color: "white"
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: fileDate
            width: 0.4 * parent.width
            height: parent.height
            color: "white"
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: fileType == "DIR" ? "文件夹" : "文件"
            width: 0.1 * parent.width
            height: parent.height
            color: "white"
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            text: fileType === "DIR" ? "" : fileSize + " KB"
            width: 0.1 * parent.width
            height: parent.height
            color: "white"
            verticalAlignment: Text.AlignVCenter
        }
    }
}
