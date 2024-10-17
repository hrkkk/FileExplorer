#include "WorkThread.h"

WorkThread::WorkThread(QObject *parent)
    : QObject{parent}
{}

void WorkThread::run()
{
    if (!m_data.isEmpty()) {
        QString filePath;
        QPixmap pixmap;

        foreach (const auto& item, m_data) {
            filePath = item.first;
            if (item.second == "IMAGE") {
                pixmap = Utils::getImageThumbnail(item.first, QSize(200, 200));
            } else if (item.second == "VIDEO") {
                pixmap = Utils::getVideoThumbnail(item.first, QSize(200, 200));
            }

            emit sign_getOneThumbnail(filePath, pixmap);
        }
    }
}

void WorkThread::slot_getData(const QList<QPair<QString, QString>>& filePaths)
{
    qDebug() << "here";
    m_data = filePaths;
}

void WorkThread::start()
{
    m_isRun = true;
}

void WorkThread::stop()
{
    m_isRun = false;
}
