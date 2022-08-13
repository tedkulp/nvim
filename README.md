# tvim (needs a better name)

This is my personal config. It's a little plugin heavy, and very inspired by
Lunarvim. But if you want to mess with it, go for it.

**Note:** This config assumes you're using a Nerd Font of some sort.  Please install one.

## Install

Close this into your nvim config directory.  Something like:

```
mkdir -p ~/.config
git clone https://github.com/tedkulp/tvim ~/.config/nvim
```

After starting neovim, run `:PackerSync` and `:PackerCompile`. Restart nvim
and you should be good.

## Portable Version

The [pvim](https://github.com/RoryNesbitt/pvim) script allows you to run neovim in
a portable manner, in case you're on some remote server and still want your config
to work.

```
git clone https://github.com/RoryNesbitt/pvim
git clone https://github.com/tedkulp/tvim pvim/config
cd pvim
./pvim
```

_TODO: Make a curl script_
