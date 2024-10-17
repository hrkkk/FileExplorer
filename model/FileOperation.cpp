#include "FileOperation.h"

FileOperation::FileOperation() {}


void FileOperation::execFile(const QString& filePath)
{
    ShellExecuteA(NULL, "open", filePath.toStdString().c_str(), NULL, NULL, SW_SHOWNORMAL);
}

void FileOperation::renameFile(const QString& filePath, const QString& newName)
{

}

void FileOperation::deleteFile(const QString& filePath)
{

}

void FileOperation::copyFile(const QString& filePath)
{

}

void FileOperation::cutFile(const QString& filePath)
{

}

void FileOperation::copyFilePath(const QString& filePath)
{

}
