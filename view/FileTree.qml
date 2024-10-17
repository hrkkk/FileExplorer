import QtQuick

Item {
    property string titleText: ""
    property var contentList: [""]

    Column {
        topPadding: 8
        leftPadding: 8
        bottomPadding: 16
        spacing: 4

        Text {
            text: titleText
            color: "white"
        }

        Repeater {
            model: contentList

            Text {
                text: "hhhh"
            }

//            Rectangle {
////                anchors.fill: parent

//                        Image {
//                            source: "qrc:/resources/file.png"
//                            width: 0.8 * parent.height
//                            height: 0.8 * parent.height
//                            fillMode: Image.PreserveAspectFit
//                        }

//                        Text {
//                            color: "white"
//                            verticalAlignment: Text.AlignVCenter
//                            horizontalAlignment: Text.AlignHCenter
//                            text: modelData

//                    }

//    //                MouseArea {
//    //                    anchors.fill: parent
//    //                    acceptedButtons: Qt.LeftButton
//    //                    hoverEnabled: true

//    //                    onEntered: {
//    //                        parent.color = "#CCE8FF"
//    //                    }

//    //                    onExited: {
//    //                        parent.color = "white"
//    //                    }
//    //                }

//            }


        }
    }
}
