#include "DataModel.h"
#include <algorithm>

DataModel::DataModel()
{
}

int DataModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    return m_profiles.count();
}

QVariant DataModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() >= m_profiles.count() || index.row() < 0) {
        return QVariant();
    }

    const Profile& profile = m_profiles[index.row()];
    if (role == TypeRole) {
        return profile.type;
    } else if (role == NameRole) {
        return profile.name;
    } else if (role == PathRole) {
        return profile.path;
    } else if (role == DateRole) {
        return profile.date;
    } else if (role == SizeRole) {
        return profile.size;
    } else if (role == IconRole) {
        return profile.icon;
    }

    return QVariant();
}

QHash<int, QByteArray> DataModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "TypeRole";
    roles[NameRole] = "NameRole";
    roles[PathRole] = "PathRole";
    roles[DateRole] = "DateRole";
    roles[SizeRole] = "SizeRole";
    roles[IconRole] = "IconRole";

    return roles;
}

void DataModel::addItem(const QString& type, const QString& name, const QString& path, const QString& date, int size, const QPixmap& icon)
{
    // 在模型的末尾插入新行时通知视图更新
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_profiles.append({type, name, path, date, size, icon});
    endInsertRows();
}


void DataModel::resetItem(const QList<Profile>& profiles)
{
    // 通知视图更新
    emit layoutAboutToBeChanged();

    m_profiles = profiles;

    emit layoutChanged();
}

void DataModel::clearItem()
{
    // 通知视图更新
    beginResetModel();
    m_profiles.clear();
    endResetModel();
}

void DataModel::sortItems(Role role)
{
    switch (role) {
        case TypeRole:
            std::sort(m_profiles.begin(), m_profiles.end(), [=](const Profile& lhs, const Profile& rhs) {
                // 如果一个是文件夹而另一个不是，则文件夹排在前面
                if (lhs.type != rhs.type) {
                    return lhs.type == "Dir";
                }

                // 如果两个都不是，则按照名称排序
                return lhs.name < rhs.name;
            });
            break;
        case NameRole:
            std::sort(m_profiles.begin(), m_profiles.end(), [=](const Profile& lhs, const Profile& rhs) {
                // 如果一个是文件夹而另一个不是，则文件夹排在前面
                if (lhs.type != rhs.type) {
                    return lhs.type == "Dir";
                }

                // 如果两个都不是，则按照名称排序
                return lhs.name < rhs.name;
            });
            break;
        case DateRole:
            std::sort(m_profiles.begin(), m_profiles.end(), [=](const Profile& lhs, const Profile& rhs) {
                // 如果一个是文件夹而另一个不是，则文件夹排在前面
                if (lhs.type != rhs.type) {
                    return lhs.type == "Dir";
                }

                // 如果两个都不是，则按照修改日期排序
                return lhs.date > rhs.date;
            });
            break;
        case SizeRole:
            std::sort(m_profiles.begin(), m_profiles.end(), [=](const Profile& lhs, const Profile& rhs) {
                // 如果一个是文件夹而另一个不是，则文件夹排在前面
                if (lhs.type != rhs.type) {
                    return lhs.type == "Dir";
                }

                // 如果两个都不是，则按照大小排序
                return lhs.size > rhs.size;
            });
            break;
        default:
            break;
    }

    QModelIndex topLeft = QAbstractListModel::index(0, 0);
    QModelIndex bottomRight = QAbstractListModel::index(m_profiles.count() - 1, 0);
    emit dataChanged(topLeft, bottomRight);
}

QPixmap DataModel::getIcon(int index) const
{
    if (index < 0 || index >= m_profiles.size()) {
        return QPixmap();
    }

    return m_profiles[index].icon;
}

void DataModel::slot_updateOneThumbnail(const QString& filePath, const QPixmap& pixmap)
{
    auto iter = std::find_if(m_profiles.begin(), m_profiles.end(), [=](const Profile& profile) {
        return profile.path == filePath;
    });

    int row = iter - m_profiles.begin();

    if (iter != m_profiles.end()) {
        m_profiles[row].icon = pixmap;
    }

    QModelIndex topLeft = createIndex(row, 0);
    QModelIndex bottomRight = createIndex(row, 0);
    emit dataChanged(topLeft, bottomRight);
}
