#include <QGuiApplication>
#include <QLocale>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine appEngine;
    appEngine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (appEngine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}


