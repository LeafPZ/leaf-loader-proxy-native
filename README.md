<div align="center">

**The native Java agent supporting [leaf-loader-proxy][LeafLoaderProxy]**

![License](https://img.shields.io/github/license/LeafPZ/leaf-loader-proxy-native?label=License)
![Build status](https://github.com/LeafPZ/leaf-loader-proxy-native/actions/workflows/build.yml/badge.svg?branch=main&label=build)
![Downloads](https://img.shields.io/github/downloads/LeafPZ/leaf-loader-proxy-native/total?label=Downloads)
![Code Size](https://img.shields.io/github/languages/code-size/LeafPZ/leaf-loader-proxy-native?label=Code%20Size)

</div>

This is a native Java agent to be used on Windows. It is required if you want to use the loader proxy, as Windows has
weird DLL search paths and the launcher doesn't correct for this behaviour.

> [!IMPORTANT]
> This native agent is only to be used for Windows as other platforms don't suffer from this issue.

## Installation

To install this to your game, you should be using [leaf-installer][LeafInstaller]. If you want to install it manually,
you need to download the latest release and place the `leaf.dll` file into `$GAME_FOLDER/.leaf/lib`.

## Usage

The installer will help you with the following, but if you wish, you can do it manually:

The native agent dll should be placed in the `$GAME_FOLDER/.leaf/lib` path as mentioned above. To allow the game to use
the native agent, you need to add `-agentlib:.leaf/lib/native-1.0.1.dll` to the game's launch options. The version
number in this example may not be the same as the version of your installed version, so change that accordingly.

If you need help with the layout of game arguments, you should read [Startup Parameters][StartupParameters].

## Configuration

You can provide arguments to the native agent. Currently the entire arguments string will be used for the `jvm.dll`
search path where the default is `.\\jre64\\bin\\server`. If you ever use a custom JVM to start the game, you will need
to edit this.

> [!CAUTION]
> The path must not contain any unicode characters such as emojis or non-ASCII characters.

| Argument | Type       | Example                   |
| -------- | ---------- | ------------------------- |
| N/A      | Positional | `.\\myjre64\\bin\\server` |

## Development

You can build the project like so:

```shell
cmake --preset release
cmake --build --preset release
```

[LeafInstaller]: https://github.com/aoqia194/leaf-installer
[LeafLoaderProxy]: https://github.com/aoqia194/leaf-loader-proxy
[StartupParameters]: https://pzwiki.net/wiki/Startup_parameters
