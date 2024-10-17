#include "Utils.h"

#include <QMimeDatabase>>
#include <QMimeType>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswscale/swscale.h>
#include <libavutil/imgutils.h>
}

Utils::Utils() {}

QPixmap Utils::getImageThumbnail(const QString& filePath, const QSize& size)
{
    QImageReader imageReader(filePath);

    QSize imageSize = imageReader.size();

    qreal scaleFactor = qMin(size.width() / static_cast<qreal>(imageSize.width()),
                             size.height() / static_cast<qreal>(imageSize.height()));

    QSize scaledSize = imageSize * scaleFactor;

    imageReader.setScaledSize(scaledSize);
    QPixmap thumbnail = QPixmap::fromImage(imageReader.read());

    return thumbnail;
}

QPixmap Utils::getVideoThumbnail(const QString& filePath, const QSize& size)
{
    QPixmap thumbnail;
    QByteArray byteArray = filePath.toUtf8();
    const char* videoPath = byteArray.constData();

    avformat_network_init();

    AVFormatContext* formatContext = avformat_alloc_context();
    // 打开视频文件
    if (avformat_open_input(&formatContext, videoPath, NULL, NULL) < 0) {
        return QPixmap();
    }

    // 获取流信息
    if (avformat_find_stream_info(formatContext, NULL) < 0) {
        return QPixmap();
    }

    // 找到第一个视频流
    int videoStream = -1;
    for (int i = 0; i < formatContext->nb_streams; i++) {
        if (formatContext->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStream = i;
            break;
        }
    }

    if (videoStream == -1) {
        return QPixmap();
    }

    // 获取视频流的编解码器上下文
    AVCodecParameters* codecParameters = formatContext->streams[videoStream]->codecpar;
    // 找到视频流对应的解码器
    const AVCodec* codec = avcodec_find_decoder(codecParameters->codec_id);
    if (codec == nullptr) {
        return QPixmap();
    }

    // 复制上下文
    AVCodecContext* codecContext = avcodec_alloc_context3(codec);
    if (avcodec_parameters_to_context(codecContext, codecParameters) < 0) {
        return QPixmap();
    }

    // 打开解码器
    if (avcodec_open2(codecContext, codec, NULL) < 0) {
        return QPixmap();
    }

    // 存储视频帧
    AVFrame* frame = av_frame_alloc();
    AVFrame* frameRGB = av_frame_alloc();
    if (frameRGB == nullptr) {
       return QPixmap();
    }

    int byteNums = 0;
    uint8_t* buffer = nullptr;
    byteNums = av_image_get_buffer_size(AV_PIX_FMT_RGB24, codecContext->width, codecContext->height, 1);
    buffer = (uint8_t*)av_malloc(byteNums * sizeof(uint8_t));

    // 关联frame和分配的内存
    av_image_fill_arrays(frameRGB->data, frameRGB->linesize, buffer, AV_PIX_FMT_RGB24, codecContext->width, codecContext->height, 1);

    // 读取数据
    AVPacket* packet = av_packet_alloc();
    struct SwsContext* swsContext = nullptr;
    swsContext = sws_getContext(codecContext->width, codecContext->height, codecContext->pix_fmt, codecContext->width, codecContext->height,
                                AV_PIX_FMT_RGB24, SWS_BILINEAR, NULL, NULL, NULL);

    // 循环读取视频帧并进行处理
    int i = 0;
    while (av_read_frame(formatContext, packet) >= 0) {
        if (packet->stream_index == videoStream) {
            // 解码视频帧  packet -> frame
            avcodec_send_packet(codecContext, packet);
            avcodec_receive_frame(codecContext, frame);
            // 将视频帧从YUV格式转换为RGB格式  YUV -> RGB
            sws_scale(swsContext, (uint8_t const* const*)frame->data, frame->linesize, 0, codecContext->height, frameRGB->data, frameRGB->linesize);

            // 如果是关键帧
            if (frame->key_frame) {
                qDebug() << "Key Frame: " << i;
            }

            // 第三帧再开始处理，避免第一帧不是关键帧
            if(++i == 3) {
                // 处理图片
                QImage image(frameRGB->data[0], codecContext->width, codecContext->height, frameRGB->linesize[0],  QImage::Format_RGB888);

                thumbnail = QPixmap::fromImage(image);
                break;
            }
        }
        av_packet_unref(packet);
    }

    // 释放内存
    if (packet) {
        av_packet_unref(packet);
    }

    if (buffer) {
        av_free(buffer);
    }

    if (frameRGB) {
        av_frame_free(&frameRGB);
    }

    if (frame) {
        av_frame_free(&frame);
    }

    if (swsContext) {
        sws_freeContext(swsContext);
    }

    if (codecContext) {
        avcodec_close(codecContext);
        avcodec_free_context(&codecContext);
    }

    if (formatContext) {
        avformat_close_input(&formatContext);
        avformat_free_context(formatContext);
    }

    return thumbnail;
}

QString Utils::identifyFileType(const QFileInfo& fileInfo)
{
    if (fileInfo.isDir()) {
        return "DIR";
    } else if (fileInfo.isFile()) {
        QMimeDatabase db;
        QMimeType mime = db.mimeTypeForFile(fileInfo.filePath());

        // 对HEIC文件进行单独处理，后续考虑使用libheic库进行更准确的识别
        // if (fileInfo.fileName().toUpper().endsWith("HEIC")) {
        //     return "IMAGE";
        // }

        if (mime.name().startsWith("image/")) {
            return "IMAGE";
        } else if (mime.name().startsWith("video/")) {
            return "VIDEO";
        } else if (mime.name().startsWith("application/")) {
            return "APPLICATION";
        } else if (mime.name().startsWith("text/")) {
            return "TEXT";
        } else if (mime.name().startsWith("audio/")) {
            return "AUDIO";
        }
    }

    return "";
}

