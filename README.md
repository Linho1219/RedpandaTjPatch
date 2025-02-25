# RedpandaTjPatch

## 简介

由于同济高级语言程序设计课程要求的编译器之一是 TDM-GCC 9.2.0，且提供了一个「定制版」的 Bloodshed Dev-C++。由于 Dev-C++ 太过古早，开发体验极差，因此想到可以使用同为 Dev-C++ 改版的 [小熊猫 C++](http://royqh.net/redpandacpp/) ，并在其中加入 TDM-GCC 9.2.0 编译器。

手动加入配置较为繁琐，因此有了本项目——自动向本地已安装的小熊猫 C++ 应用补丁。

## 这个 patcher 做些什么

1. 将同济高程用的编译器释放到小熊猫 C++ 安装目录下的 `MinGW64-TDM` 目录（为什么用这个莫名其妙的名字呢，因为 Dev-C++ 默认编译器目录名称是 `MinGW64`）
2. 读取 `%APPDATA%\RedPandaIDE\redpandacpp.ini` 并在其中追加 4 个编译器配置：
   - TDM-GCC 9.2.0 64-bit Release
   - TDM-GCC 9.2.0 64-bit Debug
   - TDM-GCC 9.2.0 32-bit Release
   - TDM-GCC 9.2.0 32-bit Debug

## 食用

确保你已安装小熊猫 C++ 并且**至少打开过一次**（小熊猫 C++ 在第一次打开时才创建配置文件）。在 [仓库 Release 页面](https://github.com/Linho1219/RedpandaTjPatch/releases/latest) 下载 patcher，双击运行即可。

> [!note]
>
> 如果你不喜欢使用 patcher，你可以下载本项目 `assets` 目录下的 `MINGW64-TDM.7z`，将其解压到你喜欢的目录。点击小熊猫 C++ 顶栏编译器下拉框右侧的设置按钮，在配置界面点击放大镜图标自动搜索你刚才放置的目录即可。

## 自行编译

### Windows

确保你已安装 [NSIS](https://nsis.sourceforge.io/Main_Page) 并添加到 PATH。

Clone 项目到本地，将 `assets/MINGW64-TDM.7z` 解压到项目根目录，在终端运行

```sh
makensis patcher.nsi
```

即可生成 `RedPandaTJPatch.exe`。

### Linux

Linux 下可使用包管理器直接安装 NSIS（例如 `sudo apt install nsis`）。

Linux 下 NSIS 使用 UTF-8 而非 GBK 编码。因此需要手动将 `patcher.nsi` 的编码转换为 UTF-8。

剩余步骤与 Windows 相同。
