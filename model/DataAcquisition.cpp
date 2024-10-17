#include "DataAcquisition.h"

DataAcquisition::DataAcquisition() {}

QList<Profile> DataAcquisition::acquireAllFiles(const QString& path)
{
    QList<Profile> fileList;

    QDir directory(path);

    QFileInfoList fileInfoList = directory.entryInfoList(QDir::NoDotAndDotDot | QDir::Dirs | QDir::Files);



    foreach (const QFileInfo& item, fileInfoList) {
        QString type = Utils::identifyFileType(item);
        QPixmap pixmap;

        if (type == "IMAGE") {
            pixmap.load("图像文件Icon");
            // pixmap = Utils::getImageThumbnail(item.filePath(), QSize(200, 200));
        } else if (type == "VIDEO") {
            pixmap.load("视频文件Icon");
            // pixmap = Utils::getVideoThumbnail(item.filePath(), QSize(200, 200));
        }

        if (pixmap.isNull()) {
            pixmap.load("C:\\Users\\hrkkk\\Documents\\FileExplorer\\resources\\file.png");
        }

        Profile profile = {
            .type = type,
            .name = item.fileName(),
            .path = item.filePath(),
            .date = item.lastModified().toString("yyyy/MM/dd h:mm"),
            .size = (int)item.size(),
            .icon = pixmap
        };

        fileList.append(profile);
    }

    return fileList;
}

QList<QPair<QString, QString>> DataAcquisition::filterMediaFile(const QList<Profile>& data)
{
    QList<QPair<QString, QString>> tasks;

    foreach (const auto& item, data) {
        if (item.type == "IMAGE") {
            tasks.append({item.path, item.type});
        } else if (item.type == "VIDEO") {
            tasks.append({item.path, item.type});
        }
    }

    return tasks;
}
