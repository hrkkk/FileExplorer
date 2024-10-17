#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QString>

#include "model/DataAcquisition.h"
#include "model/Utils.h"

class Controller : public QObject
{
    Q_OBJECT

public:
    Controller();

    enum SortMode {
        NameSortMode = 0x001,
        DateSortMode = 0x002,
        TypeSortMode = 0x003,
        SizeSortMode = 0x004,

        IncrementSortMode = 0x100,
        DecrementSortMode = 0x010
    };

    enum ShowMode {
        ListShowMode = 0,
        DetailShowMode,
        GridShowMode,
        LargeIconShowMode,
        MediumIconShowMode,
        SmallIconShowMode
    };

    QString currPath() const;
    void setCurrPath(const QString &newCurrPath);

    int itemCount() const;
    void setItemCount(int newItemCount);

    Q_INVOKABLE void taskDispatch(const QVector<QString>& command);

signals:
    void currPathChanged();

    void itemCountChanged();

    void sign_pathChanged();

    void sign_updateModel(const QList<Profile>& dataList);

    void sign_startWorkThread(const QList<QPair<QString, QString>>& filePaths);
};

#endif // CONTROLLER_H
