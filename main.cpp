#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QObject>
#include <QDir>
#include <QList>

#include "model/DataModel.h"
#include "controller/Controller.h"
#include "model/ImageProvider.h"

void createSubThread(Controller* signSendObj, DataModel* signRecvObj)
{
    WorkThread* workThread;
    QThread* thread;

    workThread = new WorkThread;
    thread = new QThread;

    workThread->moveToThread(thread);

    QObject::connect(workThread, &WorkThread::sign_getOneThumbnail, signRecvObj, &DataModel::slot_updateOneThumbnail);

    QObject::connect(signSendObj, &Controller::sign_startWorkThread, workThread, [=](const QList<QPair<QString, QString>>& filePaths) {
        workThread->slot_getData(filePaths);
        workThread->run();
    });

    thread->start();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    DataModel dataModel;
    engine.rootContext()->setContextProperty("DataModel", &dataModel);

    ImageProvider* imageProvider = new ImageProvider();
    imageProvider->setImageModel(&dataModel);

    engine.addImageProvider("ImageProvider", imageProvider);

    Controller controller;
    engine.rootContext()->setContextProperty("ControllerObject", &controller);
    emit controller.currPathChanged();

    createSubThread(&controller, &dataModel);

    QObject::connect(&controller, &Controller::sign_updateModel, &dataModel, [&](const QList<Profile>& dataList) {
        dataModel.resetItem(dataList);
    });

    // 加载QML文件
    const QUrl url(u"qrc:/FileExplorer/view/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
