#include "Controller.h"
#include <QDebug>
#include <QDir>
#include <model/FileOperation.h>
#include <model/DataAcquisition.h>

Controller::Controller()
{

}

void Controller::taskDispatch(const QVector<QString>& command)
{
    int commandCount = command.size();

    if (commandCount < 1) {
        return;
    }

    if (command[0] == "Back") {

    } else if (command[0] == "Forward") {

    } else if (command[0] == "PathChanged") {
        if (commandCount == 3) {
            if (command[1] == "ListMode") {
                auto dataList = DataAcquisition::acquireAllFiles(command[2]);
                emit sign_updateModel(dataList);
            } else if (command[1] == "GridMode") {
                auto dataList = DataAcquisition::acquireAllFiles(command[2]);
                auto mediaFileList = DataAcquisition::filterMediaFile(dataList);

                if (mediaFileList.size() > 0) {
                    emit sign_startWorkThread(mediaFileList);
                }
                emit sign_updateModel(dataList);
            }
        }
    } else if (command[0] == "OpenFile") {
        if (commandCount == 3) {
            QString filePath = command[1] + "\\" + command[2];
            FileOperation::execFile(filePath);
        }
    } else if (command[0] == "RenameFile") {
        FileOperation::renameFile(command[1], command[2]);
    } else if (command[0] == "DeleteFile") {
        FileOperation::deleteFile(command[1]);
    } else if (command[0] == "CopyFile") {
        FileOperation::copyFile(command[1]);
    } else if (command[0] == "CopyFilePath") {
        FileOperation::copyFilePath(command[1]);
    }
}
