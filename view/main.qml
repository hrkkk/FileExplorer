import QtQuick
import QtQuick.Controls


Window {
    property string g_CurrPath: "K:"
    property int g_modelCount: 0

    property int skinMode: 0

    property var blackSkinColor: {
        "header": "#33518d",
        "top": "#262632",
        "left": "#262632",
        "main": "#262632",
        "bottom": "#262632",
        "font": "#ffffff"
    }

    property var lightSkinColor: {
        "header": "#0383da",
        "top": "#7ecfff",
        "left": "#f5f4f2",
        "main": "#ffffff",
        "bottom": "#fffeff",
        "font": "#000000"
    }

    id: rootWindow
    width: 1200
    height: 700
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint

    Component.onCompleted: {
        setPathContent(g_CurrPath)
        ControllerObject.taskDispatch(["PathChanged", "GridMode", g_CurrPath])
    }

    onG_CurrPathChanged: {
        if (g_CurrPath.charAt(g_CurrPath.length - 1) === ":") {
            backBtn.enabled = false
        } else {
            backBtn.enabled = true
        }
    }

    // 标题栏
    Rectangle {
        id: head
        anchors {
            left: parent.left
            top: parent.top
        }
        width: parent.width
        height: 20
        color: skinMode === 0 ? blackSkinColor["header"] : lightSkinColor["header"]

        Rectangle {
            id: closeBtn
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 8
            }
            color: "#FF5953"
            width: 12
            height: width
            radius: width / 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton

                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }

                onClicked: {
                    Qt.quit()
                }
            }
        }

        Rectangle {
            id: resizeBtn
            anchors {
                verticalCenter: parent.verticalCenter
                left: closeBtn.right
                leftMargin: 8
            }
            color: "#E6C02A"
            width: 12
            height: width
            radius: width / 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton

                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }

                onClicked: {
                    rootWindow.showMinimized()
                }
            }
        }

        Rectangle {
            id: minBtn
            anchors {
                verticalCenter: parent.verticalCenter
                left: resizeBtn.right
                leftMargin: 8
            }
            color: "#53C32B"
            width: 12
            height: width
            radius: width / 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton

                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                }

                onClicked: {
                    if (rootWindow.visibility === Window.Maximized) {
                        rootWindow.showNormal()
                    } else {
                        rootWindow.showMaximized()
                    }
                }
            }
        }

        Switch {
            id: skinSwitch
            anchors {
                verticalCenter: parent.verticalCenter
                left: minBtn.right
                leftMargin: 8
            }
            text: "Dark Mode"

            onCheckedChanged: {
                if (skinSwitch.checked) {
                    skinMode = 1;
                    skinSwitch.text = "Light Mode";
                } else {
                    skinMode = 0;
                    skinSwitch.text = "Dark Mode";
                }
            }
        }

        Text {
            id: title
            anchors.centerIn: parent
            text: "文件资源浏览器"
            color: "white"
        }
    }

    // 顶部导航栏
    Rectangle {
        id: topNavigation
        anchors {
            left: parent.left
            top: head.bottom
        }
        width: parent.width
        height: 30
        color: skinMode === 0 ? blackSkinColor["top"] : lightSkinColor["top"]

        Rectangle {
            id: backBtn
            anchors {
                left: parent.left
                leftMargin: 8
                verticalCenter: parent.verticalCenter
            }
            width: 20
            height: width
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/prev.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    let lastSlashIndex = g_CurrPath.lastIndexOf("\\")
                    let basePath = g_CurrPath.substring(0, lastSlashIndex)
                    g_CurrPath = basePath
                    setPathContent(g_CurrPath)
                    ControllerObject.taskDispatch(["PathChanged", "GridMode", g_CurrPath])
                }
            }
        }

        Rectangle {
            id: forwardBtn
            anchors {
                left: backBtn.right
                leftMargin: 3
                verticalCenter: parent.verticalCenter
            }
            width: 20
            height: width
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/next.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    ControllerObject.taskDispatch("Forward")
                }
            }
        }

        Rectangle {
            id: showModeBtn1
            anchors {
                left: parent.left
                leftMargin: leftNavigation.width
                verticalCenter: parent.verticalCenter
            }
            width: 25
            height: 20
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/gridview.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {

                }
            }
        }

        Rectangle {
            id: showModeBtn2
            anchors {
                left: showModeBtn1.right
                verticalCenter: parent.verticalCenter
            }
            width: 25
            height: 20
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/listview.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {

                }
            }
        }

        Rectangle {
            id: showModeBtn3
            anchors {
                left: showModeBtn2.right
                verticalCenter: parent.verticalCenter
            }
            width: 25
            height: 20
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/disk.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {

                }
            }
        }

        Rectangle {
            id: showModeBtn4
            anchors {
                left: showModeBtn3.right
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            width: 25
            height: 20
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/setting.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {

                }
            }
        }

        Rectangle {
            id: showModeBtn5
            anchors {
                left: showModeBtn4.right
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            width: 25
            height: 20
            radius: 5
            color: "#67676A"

            Image {
                source: "qrc:/resources/task.png"
                width: 0.8 * parent.width
                height: 0.8 * parent.height
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {

                }
            }
        }

        Rectangle {
            width: 200
            height: 0.8 * parent.height
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            color: "transparent"
            border.width: 1
            radius: 3

            TextInput {
                id: searchArea
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
                text: "hello world"
            }
        }
    }

    // 左侧导航栏
    Rectangle {
        id: leftNavigation
        anchors {
            top: topNavigation.bottom
            left: parent.left
        }
        width: 200
        height: parent.height - head.height - topNavigation.height
        color: skinMode === 0 ? blackSkinColor["left"] : lightSkinColor["left"]
        border.width: 1

        ScrollView {
            anchors.fill: parent

            Column {
                anchors.fill: parent

                Text {
                    color: "white"
                    text: "个人收藏"
                    leftPadding: 5
                    bottomPadding: 10
                    topPadding: 5
                }

                Repeater {
                    width: parent.width
                    model: ["隔空投送", "应用程序", "影片", "下载", "音乐", "图片"]

                    Rectangle {
                        width: 200
                        height: 25
                        color: "transparent"

                        Row {
                            anchors.fill: parent
                            leftPadding: 20
                            spacing: 3

                            Image {
                                source: "qrc:/resources/disk.png"
                                width: 0.8 * parent.height
                                height: 0.8 * parent.height
                                fillMode: Image.PreserveAspectFit
                                mipmap: true
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                color: "white"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: modelData
                            }
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
                        }
                    }
                }

                Text {
                    color: "white"
                    text: "位置"
                    leftPadding: 5
                    topPadding: 20
                    bottomPadding: 10
                }

                Repeater {
                    width: parent.width
                    model: ["OS(C:)", "PRO(D:)", "Soft(G:)", "HDD(H:)", "Spaceman(K:)"]

                    Rectangle {
                        width: 200
                        height: 25
                        color: "transparent"

                        Row {
                            anchors.fill: parent
                            leftPadding: 20
                            spacing: 3

                            Image {
                                source: "qrc:/resources/disk.png"
                                width: 0.8 * parent.height
                                height: 0.8 * parent.height
                                fillMode: Image.PreserveAspectFit
                                anchors.verticalCenter: parent.verticalCenter
                                mipmap: true
                            }

                            Text {
                                color: "white"
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                text: modelData
                            }
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
                                // 使用正则提取盘符
                                const regex = /\((.*?)\)/;
                                const match = modelData.match(regex);

                                if (match && match.length > 1) {
                                    gridView.visible = false;
                                    g_CurrPath = match[1];
                                    setPathContent(g_CurrPath);
                                    ControllerObject.taskDispatch(["PathChanged", "GridMode", g_CurrPath]);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // 底部导航栏
    Rectangle {
        id: bottomNavigation
        anchors {
            left: leftNavigation.right
            right: parent.right
            bottom: parent.bottom
        }
        color: skinMode === 0 ? blackSkinColor["bottom"] : lightSkinColor["bottom"]
        width: parent.width - leftNavigation.width
        height: 30

        property var dynamicObject: null

        Text {
            id: statusText
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: g_modelCount + " 个项目"
            color: "#ffffff"
        }
    }

    // 文件显示区域
    Rectangle {
        id: mainArea
        color: skinMode === 0 ? blackSkinColor["main"] : lightSkinColor["main"]
        anchors {
            top: topNavigation.bottom
            left: leftNavigation.right
            right: parent.right
        }
        width: parent.width - leftNavigation.width
        height: parent.height - head.height - topNavigation.height - bottomNavigation.height



        ScrollView {
            id: scrollView
            anchors.fill: parent


            // MouseArea {
            //     anchors.fill: parent

            //     onWheel: {
            //         if (wheel.angleDelta.y > 0) {   // 向上滚动
            //             console.log("y++")
            //             scrollView.locale
            //             scrollView.contentY += 10
            //         } else {
            //             console.log("y--")
            //             scrollView.contentY -= 10
            //         }
            //     }
            // }

            // ListView {
            //     width: parent.width
            //     anchors.fill: parent
            //     anchors.margins: 20
            //     spacing: 10
            //     clip: true

            //     model: DataModel
            //     delegate: FileComponent {
            //         fileName: NameRole
            //         fileDate: DateRole
            //         fileType: TypeRole
            //         fileSize: SizeRole

            //         onItemDoubleClicked: function(itemFileName, itemFileType) {
            //             if (itemFileType === "DIR") {
            //                 g_CurrPath = g_CurrPath + "\\" + itemFileName
            //                 setPathContent(g_CurrPath)
            //                 ControllerObject.taskDispatch(["PathChanged", "ListMode", g_CurrPath])
            //             } else {
            //                 ControllerObject.taskDispatch(["OpenFile", g_CurrPath, itemFileName])
            //             }
            //         }

            //         onItemRightClicked: function(itemFileName) {
            //             itemMenu.popup()
            //         }
            //     }
            // }

            Timer {
                id: gapTimer
                interval: 100
                running: false

                onTriggered: {
                    if (!gridView.visible) {
                        gridView.visible = true;
                    }
                }
            }

            GridView {
                id: gridView
                anchors.fill: parent
                cellWidth: 200
                cellHeight: 200
                clip: true

                model: DataModel

                onCountChanged: {
                    if (gridView.model !== null) {
                        g_modelCount = gridView.model.rowCount()
                    }
                    if (!gridView.visible && !gapTimer.running) {
                        gapTimer.start();
                    }
                }

                delegate: LargeIconComponent {
                    width: 180
                    height: 180

                    imageSource: {
                        if ((TypeRole === "IMAGE" || TypeRole === "VIDEO") && index != -1) {
                            return "image://ImageProvider/" + index
                        } else if (TypeRole === "DIR") {
                            return "qrc:/resources/dir.png"
                        } else {
                            return "qrc:/resources/file.png"
                        }
                    }
                    fileName: NameRole
                    fileType: TypeRole

                    onItemDoubleClicked: function(itemFileName, itemFileType) {
                        if (itemFileType === "DIR") {
                            gridView.visible = false;
                            g_CurrPath = g_CurrPath + "\\" + itemFileName
                            setPathContent(g_CurrPath)
                            ControllerObject.taskDispatch(["PathChanged", "GridMode", g_CurrPath])
                        } else {
                            ControllerObject.taskDispatch(["OpenFile", g_CurrPath, itemFileName])
                        }
                    }

                    onItemRightClicked: function(itemFileName) {
                        itemMenu.popup()
                    }
                }
            }
        }
    }

    Menu {
        id: itemMenu

        MenuItem {
            text: "打开"
        }

        MenuSeparator {}

        MenuItem {
            text: "剪切"
        }

        MenuItem {
            text: "复制"
        }

        MenuItem {
            text: "重命名"
        }

        MenuItem {
            text: "删除"
        }

        MenuSeparator {}

        Menu {
            title: "更多选项"

            MenuItem {
                text: "复制地址"
            }
        }
    }



    function setPathContent(path) {
        var resultArray = path.split("\\")

        if (bottomNavigation.dynamicObject) {
            bottomNavigation.dynamicObject.destroy()
        }

        var component = Qt.createComponent("PathNavigation.qml")

        if (component.status === Component.Ready) {
            bottomNavigation.dynamicObject = component.createObject(bottomNavigation, {
                                                           pathList: resultArray
                                                       })
        }
    }
}
