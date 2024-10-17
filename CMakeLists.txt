cmake_minimum_required(VERSION 3.16)

project(FileExplorer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(FFMPEG ${CMAKE_SOURCE_DIR}/3rdLibrary/FFmpeg)

find_package(Qt6 6.6 COMPONENTS Quick REQUIRED)

# 导入 ffmpeg 的头文件
include_directories(${FFMPEG}/include)

# 引入 ffmpeg 的库文件
link_directories(${FFMPEG}/lib)


qt_add_executable(appFileExplorer
    main.cpp resources.qrc
    model/DataModel.h
    model/DataModel.cpp
    controller/Controller.h
    controller/Controller.cpp
)

qt_add_qml_module(appFileExplorer
    URI FileExplorer
    VERSION 1.0

    QML_FILES
    view/FileComponent.qml
    view/FileMenu.qml
    view/FileTree.qml
    view/main.qml
    view/MyButton.qml
    view/PathNavigation.qml
    view/LargeIconComponent.qml

    SOURCES
    model/FileOperation.h model/FileOperation.cpp
    model/DataAcquisition.h model/DataAcquisition.cpp
    model/ImageProvider.h model/ImageProvider.cpp
    model/Utils.h model/Utils.cpp
    SOURCES model/WorkThread.h model/WorkThread.cpp
)


set_target_properties(appFileExplorer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFileExplorer
    PRIVATE Qt6::Quick
    avformat
    avcodec
    avdevice
    avfilter
    avutil
    postproc
    swresample
    swscale)

install(TARGETS appFileExplorer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
