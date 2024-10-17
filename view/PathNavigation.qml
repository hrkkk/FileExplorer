import QtQuick

Row {
    property var pathList: [""]

    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.leftMargin: 10
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        model: pathList
        delegate: Rectangle {
            width: 16 * countChineseCharacters(modelData) + 9 * (modelData.length - countChineseCharacters(modelData)) + 10
            height: 30
            color: "transparent"

            Text {
                anchors.left: parent.left
                text: ">"
                color: "#ffffff"
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MyButton {
                buttonText: modelData
                anchors.right: parent.right
            }

            function countChineseCharacters(str) {
                var chineseRegex = /[\u4e00-\u9fa5]/g;
                var chineseMatches = str.match(chineseRegex);

                var count = chineseMatches ? chineseMatches.length : 0;
                return count;
            }
        }
    }
}
