#ifndef UTILS_H
#define UTILS_H


#include <QPixmap>
#include <QString>
#include <QSize>
#include <QImageReader>
#include <QFileInfo>

#include <iostream>
#include <thread>

class Utils
{
public:
    Utils();

    static QPixmap getImageThumbnail(const QString& filePath, const QSize& size);
    static QPixmap getVideoThumbnail(const QString& filePath, const QSize& size);
    static QString identifyFileType(const QFileInfo& fileInfo);
};

#endif // UTILS_H
