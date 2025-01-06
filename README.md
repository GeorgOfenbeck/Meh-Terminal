# How to get the 'Meh'  (Ctrl-Alt-Shift / C-M-S (tmux) / C-A-S (vim)) Key to work in the terminal

If you are only interessted in the TL:DR check out how i replicated https://blog.zsa.io/vscode-tips/ for the Terminal [here](#terminal--tmux--nvim)

## Motivation
I'm a big fan of using "special" modifier keys on my [ZSA Voyager Keyboard](https://www.zsa.io/voyager) that are not commonly used with regular keyboards.

I'm refering mainly to the "Meh" Key which is the eqivalent of pressing Ctrl-Alt-Shift and the Hyper Key which equals to Alt+Shift+Ctrl+Cmd.

Just think of them as your common Ctrl+B modifier in Tmux, your Ctrl+C/Cmd+C to copy etc.

What makes them special tough is that on a regular keyboard they require quite some finger gymnastics and are hence nearly never used for predefined shortcuts.

And thats exactly the beauty of it - when configuring Meh/Hyper Shortcuts you basically never have to worry about conflicts with pre existing shortcuts. [unless MS decides to abuse it](#windows)

### Keyboard layout
I have a bit of an [exotic keyboard layout](https://configure.zsa.io/voyager/layouts/erxEm/EGL5Q/2) - I'm using the "Recurva" layout - customized to windows and Mac OS on seperate layers.

I mention this just that one doesn't get surpised by my shortcuts - as my key position are shifted some shortcuts might seem odd at first.

### OS level shortcuts:

Personally I used hyper keys for OS level shortcuts.
#### Mac OS 
E.g in MacOS i use the hyperkey with my left Keyboard Half with rectangular for Windows Movements.
The right Keyboard Half I use with [Hammerspoon](https://github.com/GeorgOfenbeck/dotfiles/blob/main/hammerspoon/init.lua) to launch applications.

#### Windows
Windows unfortunatly is a bit harder to get to work with hyper keys.
I use the [Fancy Zones](https://learn.microsoft.com/en-us/windows/powertoys/fancyzones) with their (to my knowledge) no easily modifiable shortcut to move windows.

For application launching i use [Auto Hotkey](https://autohotkey.com/)

Unfortunatly Microsoft decided they gonna abuse the Hyper Key for their custom Keyboards with a "Office" Key - one needs to disable this [manually](https://deskthority.net/wiki/Hyper_key#:~:text=to%20another%20key.-,Microsoft%20Windows,Control%2BAlt%2BWindows%20simultaneously.) 


### Tooling Shortcuts

#### VS Code 
Previously I mainly used VS Code for my coding work. Within VS Code i use my second set of shortcuts which are all based around the Meh Key.
This was all inspired by the excellent article of [Giles Knap here on Github](https://github.com/gilesknap/zsa-voyager-vscode) which i found through his blog article on the [ZSA blog](https://blog.zsa.io/vscode-tips/).


I moved my keybinds to Meh instead of hyper and atapted them to my keyboard layout - but kept the layout in terms of physical keys on the Voyager Keyboard - my config can be found [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/vscode/keybindings.json).

#### Terminal / Tmux / Nvim

I really liked the VS code workflow to change tabs/windows / move around.
I'm a big user of Vim Motions in VS code. (can highly recommend [This plugin](https://marketplace.visualstudio.com/items?itemName=vintharas.learn-vim) if you want to start this journey as well)

As it seems that for many thats just the entry drug into the whole NeoVim experience, I decided to also give that a try recently.
As i really like the VS Code Meh Shortcuts I wanted to adapt that for the Terminal - turns out thats not as straightforward as expected.
Long story short - the whole pupose of this git repo is to save someone else the trouble figuring it out.

##### Terminal 
You need to forward the Mey Key to the application running inside you terminal - that is not done by default.
For debugging "showkey -a" 

for Meh+r you want to get 
```
➜ showkey -a

Press any keys - Ctrl-D will terminate this program

^[[27;8;114~     27 0033 0x1b
         91 0133 0x5b
         50 0062 0x32
         55 0067 0x37
         59 0073 0x3b
         56 0070 0x38
         59 0073 0x3b
         49 0061 0x31
         49 0061 0x31
         52 0064 0x34
        126 0176 0x7e
```

To achive this in the windows terminal you need to forward the keys as shown [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/windowsTerminal/settings.json) using [ms docu](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/actions)

For WezTerm i did it using this [config](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/wezterm/bindings.lua)

##### Multiplexing (Wezterm / Tmux)
I first wanted to go with terminal native multiplexing in wezterm (my attempt can be found [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/wezterm/bindings.lua.multiplex)) but ultimativly gave up on it and went with a "classic" tmux setup.
The issue was that on windows making neovim/multiplexing setup seemless is very hard due to the wsl process being the detected one as described [here](https://github.com/wez/wezterm/issues/3137)
If you are a pure linux / mac user that might still be an option for you if you dont wanna use tmux (e.g for performance reasons without the need for sessions)

In my case I went with a classic Tmux setup - but turns out also this was not straightforward - Tmux "swallows" the Mey Key by default - and forwarding it requires to configure forwarding Key Sequences similar to the Windows Terminal Setup.

The working config can be found [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/tmux/tmux.bindings.conf) - it uses a similar setup as [vs code key layout](https://github.com/gilesknap/zsa-voyager-vscode/raw/main/navonly.svg).

On my right [exotic keyboard layout](https://configure.zsa.io/voyager/layouts/erxEm/EGL5Q/2) that results in the following mapping:


| 6   | 7   | 8   | 9   | 0   | -           |
| --- | --- | --- | --- | --- | ----------- |
| q   | l   | u   | o   | y   | \           |
| j   | h   | e   | a   | i   | right Arrow |
| ;   | m   | ,   | .   | .   | down Arrow  |


|                                                       |                       |                           |                              |                             |                                               |
| ----------------------------------------------------- | --------------------- | ------------------------- | ---------------------------- | --------------------------- | --------------------------------------------- |
| 6 =Split window horizontally with current pane's path | 7 = Swap pane         | 8 = Resize pane up by 7   | 9 = Swap window to right     | 0 = Kill pane               | -                                             |
| q = Split window vertically with current pane's path  | l = Previous window   | u = Select pane above     | o = Next window              | y = paste buffer            | \ = Syncronize panes                          |
| j = Resize pane left by 20                            | h = Select pane left  | e = Select pane down      | a = Select pane on the right | i = Resize pane right by 20 | right arrow = new window with home directory  |
| ;  = toogle pane zoom                                 | m = copy mode page up | , = Resize pane down by 7 | . = copy mode page down      | . = tmux fzf                | down arrow =  Clear screen and send Enter key |



##### Neovim

Finally the last piece of the puzzle - and the only one that "just worked" - getting tmux and neovim to work transparently in terms of moving / splitting windows can be found in a minimal version [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/nvim/init.lua)