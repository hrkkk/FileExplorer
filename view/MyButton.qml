import QtQuick
import QtQuick.Controls

Rectangle {
    property string buttonText: ""

    width: 16 * countChineseCharacters(buttonText) + 9 * (buttonText.length - countChineseCharacters(buttonText))
    height: parent.height
    radius: 5
    color: "transparent"

    Text {
        text: buttonText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 12
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        hoverEnabled: true

        onEntered: {
            parent.color = "#797277"
        }

        onExited: {
            parent.color = "transparent"
        }

        onClicked: {

        }
    }

    function countChineseCharacters(str) {
        var chineseRegex = /[\u4e00-\u9fa5]/g;
        var chineseMatches = str.match(chineseRegex);

        var count = chineseMatches ? chineseMatches.length : 0;
        return count;
    }
}
