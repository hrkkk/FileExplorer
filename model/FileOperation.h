#ifndef FILEOPERATION_H
#define FILEOPERATION_H

#include <QString>
#include <Windows.h>

class FileOperation
{
public:
    FileOperation();

    static void execFile(const QString& filePath);
    static void renameFile(const QString& filePath, const QString& newName);
    static void deleteFile(const QString& filePath);
    static void copyFile(const QString& filePath);
    static void cutFile(const QString& filePath);
    static void copyFilePath(const QString& filePath);
};

#endif // FILEOPERATION_H
