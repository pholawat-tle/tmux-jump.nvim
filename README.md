# tmux-jump.nvim

A slight modification of the tmux module from [harpoon](https://github.com/ThePrimeagen/harpoon)
that allow you to jump between neovim and other tmux windows with ease

## Motivation

I often find myself jumping back and forth between neovim and other tmux windows(to execute shell
commands or whatever).

I was using harpoon to do exactly this but there's a problem with tmux pane messing up the plugin and 
the window history doesn't persist when I accidentally. I've decided to make this a standalone plugin
to solve this trivial problem of mine.

## :package: Installation

Install this plugin with your favorite package manager:

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
-- Lua
use "nvim-lua/plenary.nvim"
use "pholawat-tle/tmux-jump.nvim"
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
" Vim Script
Plug "nvim-lua/plenary.nvim"
Plug "pholawat-tle/tmux-jump.nvim"
```

## :gear: Usage

### tmux Window Navigation

```vim
" if it doesn't already exists, create a tmux window with index 2
" goes to tmux window with index 2
:lua require("tmux-jump.navigation").gotoWindow(2) 
```

### Switching back to neovim

In your `tmux.conf` (or anywhere you have keybinds), add this

```bash
bind-key -r G run-shell "path-to-plugins/tmux-jump.nvim/scripts/switch-back-to-nvim"
```

### Example Configuration

This is how I have it configured

```vim
" Jump back and forth between neovim and my other window with Ctrl+g
nnoremap <C-g> :lua require("tmux-jump.navigation").gotoWindow(2)<CR> 

nnoremap <leader>tq :lua require("tmux-jump.navigation").gotoWindow(2)<CR>
nnoremap <leader>tw :lua require("tmux-jump.navigation").gotoWindow(3)<CR>
nnoremap <leader>te :lua require("tmux-jump.navigation").gotoWindow(4)<CR>
nnoremap <leader>tr :lua require("tmux-jump.navigation").gotoWindow(5)<CR>
```
