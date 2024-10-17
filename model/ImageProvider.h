#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>

#include "DataModel.h"

class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider();

    QPixmap requestPixmap(const QString& id, QSize* size, const QSize& requestedSize) override;

    void setImageModel(DataModel* imageModel);

private:
    DataModel* m_imageModel;
};

#endif // IMAGEPROVIDER_H
