# Ted's Neovim Config

This is my personal config. It's a little plugin heavy, and very inspired by
Lunarvim. But if you want to mess with it, go for it.

_**Note:** This config assumes you're using a Nerd Font of some sort.  Please install one._
_**Note:** This config relies on 0.8+ versions of Neovim. Use at your own risk if it's something older._

## Install

Close this into your nvim config directory.  Something like:

``` bash
mkdir -p ~/.config
git clone https://github.com/tedkulp/nvim ~/.config/nvim
```

After starting neovim, run `:PackerSync` and `:PackerCompile`. Restart nvim
and you should be good.

## Portable Version

The [pvim](https://github.com/RoryNesbitt/pvim) script allows you to run neovim in
a portable manner (on Linux -- it uses an appimage), in case you're on some remote
server and still want your config to work.

``` bash
git clone https://github.com/RoryNesbitt/pvim
git clone https://github.com/tedkulp/nvim pvim/config
cd pvim
./pvim
```

_**TODO:** Make a curl script_

## Docker Version

There is also an automated build of this config built along with the latest stable
version of neovim. Sometimes it's just easier to use Docker to do some quick editing
on a strange machine.

It defaults to the `/data` directory.  You can start it with something like

``` bash
docker run --rm -it -v $(pwd):/data tedkulp/nvim
```
