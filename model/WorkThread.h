#ifndef WORKTHREAD_H
#define WORKTHREAD_H

#include <QObject>
#include <QPixmap>
#include <QString>
#include <QPair>
#include <QThread>

#include "Utils.h"

class WorkThread : public QObject
{
    Q_OBJECT
public:
    explicit WorkThread(QObject *parent = nullptr);

    void run();
    void start();
    void stop();

signals:
    void sign_getOneThumbnail(const QString& filePath, const QPixmap& pixmap);

public slots:
    void slot_getData(const QList<QPair<QString, QString>>& filePaths);

private:
    bool m_isRun;
    QList<QPair<QString, QString>> m_data;
};

#endif // WORKTHREAD_H
