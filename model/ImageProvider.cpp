#include "ImageProvider.h"

ImageProvider::ImageProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap), m_imageModel(nullptr)
{}

QPixmap ImageProvider::requestPixmap(const QString& id, QSize* size, const QSize& requestedSize)
{
    if (id.toInt() < 0) {
        return QPixmap();
    }

    if (m_imageModel && size) {
        *size = requestedSize;
    }

    if (m_imageModel) {
        return m_imageModel->getIcon(id.toInt());
    }

    return QPixmap();
}

void ImageProvider::setImageModel(DataModel* imageModel)
{
    m_imageModel = imageModel;
}
