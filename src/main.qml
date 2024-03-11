import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 200
    height: 100
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "white"

        Text {
            anchors.centerIn: parent
            text: "Hello, World!"
        }
    }
}
