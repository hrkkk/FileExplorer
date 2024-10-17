#ifndef DATAACQUISITION_H
#define DATAACQUISITION_H

#include <QString>
#include <QList>
#include <QDir>
#include <QFileInfoList>
#include <QPixmap>
#include <QThread>

#include "Utils.h"
#include "WorkThread.h"

struct Profile {
    QString type;
    QString name;
    QString path;
    QString date;
    int size;
    QPixmap icon;
};

class DataAcquisition
{
public:
    DataAcquisition();

    static QList<Profile> acquireAllFiles(const QString& path);
    static QList<QPair<QString, QString>> filterMediaFile(const QList<Profile>& data);
};

#endif // DATAACQUISITION_H
