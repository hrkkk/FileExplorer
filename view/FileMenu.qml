import QtQuick
import QtQuick.Controls

Item {
    Menu {
        id: itemMenu
        MenuItem {
                        text: "Cut"
//                            shortcut: "Ctrl+X"
                        onTriggered: {}
                    }

                    MenuItem {
                        text: "Copy"
//                            shortcut: "Ctrl+C"
                        onTriggered: {}
                    }

                    MenuItem {
                        text: "Paste"
//                            shortcut: "Ctrl+V"
                        onTriggered: {}
                    }

                    MenuSeparator { }

                    Menu {
                        title: "More Stuff"

                        MenuItem {
                            text: "Do Nothing"
                        }
                    }
    }

}
