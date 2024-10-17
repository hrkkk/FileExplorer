#ifndef DATA_MODEL_H
#define DATA_MODEL_H

#include <QAbstractListModel>

#include "DataAcquisition.h"

class DataModel : public QAbstractListModel
{
    Q_OBJECT
public:
    DataModel();

    enum Role {
        TypeRole = Qt::UserRole + 1,
        NameRole,
        PathRole,
        DateRole,
        SizeRole,
        IconRole
    };

    // 重写以下几个虚函数
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addItem(const QString& type, const QString& name, const QString& path, const QString& date, int size, const QPixmap& icon);
    void resetItem(const QList<Profile>& profiles);
    void clearItem();
    void sortItems(Role role);
    QPixmap getIcon(int index) const;

public slots:
    void slot_updateOneThumbnail(const QString& filePath, const QPixmap& pixmap);

private:
    QList<Profile> m_profiles;
};

#endif // DATA_MODEL_H
