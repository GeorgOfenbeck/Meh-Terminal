# Getting the 'Meh' Key (Ctrl+Shift+Alt / C-M-S / C-A-S) to Work in the Terminal

If you're just looking for the TL;DR on replicating [this ZSA blog post](https://blog.zsa.io/vscode-tips/) for the terminal, check out the instructions [here](#terminal--tmux--nvim).

## Motivation
I'm a big fan of using "special" modifier keys on my [ZSA Voyager Keyboard](https://www.zsa.io/voyager) that are not commonly available on standard keyboards.

I'm referring specifically to the "Meh" key (equivalent to pressing `Ctrl+Alt+Shift`) and the "Hyper" key (equivalent to `Ctrl+Alt+Shift+Cmd`).

Think of them as analogous to common modifiers like `Ctrl+B` in Tmux or `Ctrl+C`/`Cmd+C` for copying. However, their unique advantage is that they avoid the "finger gymnastics" required on a standard keyboard, making them ideal for shortcuts without conflicts—unless, of course, Microsoft decides to misuse them (see [Windows](#windows)).

### Keyboard Layout
I use an [exotic keyboard layout](https://configure.zsa.io/voyager/layouts/erxEm/EGL5Q/2), "Recurva," customized for Windows and macOS on separate layers. Keep this in mind as my key positions might look unusual.

### OS-Level Shortcuts using Hyper

#### macOS
On macOS, I use the Hyper key for OS-level shortcuts. For example:
- The left half of my keyboard is configured for [Rectangle](https://rectangleapp.com/) window movements.
- The right half is set up with [Hammerspoon](https://github.com/GeorgOfenbeck/dotfiles/blob/main/hammerspoon/init.lua) to launch applications.

#### Windows
Windows makes using Hyper keys trickier:
- I use [FancyZones](https://learn.microsoft.com/en-us/windows/powertoys/fancyzones) for window management, though its shortcuts are not easily customizable.
- For application launching, I rely on [AutoHotkey](https://autohotkey.com/).

Unfortunately, Microsoft uses the Hyper key for its proprietary "Office" key, which you need to disable manually ([details here](https://deskthority.net/wiki/Hyper_key#:~:text=to%20another%20key.-,Microsoft%20Windows,Control%2BAlt%2BWindows%20simultaneously.)).

### Tooling Shortcuts using Meh

#### VS Code
I originally used VS Code for coding, leveraging Meh-based shortcuts inspired by [this GitHub repository](https://github.com/gilesknap/zsa-voyager-vscode) and [blog post](https://blog.zsa.io/vscode-tips/). My modified keybindings, adapted to my layout, are available [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/vscode/keybindings.json).

#### Terminal / Tmux / Nvim
As a heavy user of Vim motions in VS Code, transitioning to Neovim was a natural progression. I wanted to replicate the Meh shortcuts from VS Code for the terminal, which proved to be more challenging than expected. This repository aims to save others the trouble of figuring it out.

##### Terminal
Forwarding the Meh key to terminal applications is not default behavior!
I relied a lot on using `showkey -a` for debugging:
E.g Meh+r should result in:
```bah
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

For Windows Terminal, forward the keys as shown [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/windowsTerminal/settings.json) and follow [Microsoft's documentation](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/actions).

For WezTerm, this [configuration](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/wezterm/bindings.lua) works for me.

##### Multiplexing (WezTerm / Tmux)
Initially, I explored native multiplexing in WezTerm ([attempt here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/wezterm/bindings.lua.multiplex)), but Windows' handling of WSL processes caused issues ([details here](https://github.com/wez/wezterm/issues/3137)). Linux/macOS users might still prefer this for performance reasons.

I ultimately chose Tmux but had to configure key sequence forwarding, as Tmux "swallows" the Meh key by default. My working configuration is available [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/tmux/tmux.bindings.conf).

##### Neovim
Integrating Tmux and Neovim for seamless window management "just worked." A minimal Neovim setup is [here](https://github.com/GeorgOfenbeck/Meh-Terminal/blob/main/nvim/init.lua).

### Tmux Shortcut Layout
My Tmux keybinding layout, inspired by [this VS Code layout](https://github.com/gilesknap/zsa-voyager-vscode/raw/main/navonly.svg), results in the following mappings for my right keyboard half


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
| ;  = toogle pane zoom                                 | m = copy mode page up | , = Resize pane down by 7 | . = copy mode page down      | . = tmux fzf                | down arrow =  Clear screen and send Enter key |


## Conclusion
This guide reflects my personal setup and preferences. By documenting this, I hope to help others that might wanna use Hyper/Meh in the terminal as information on this at the time of writing is sparse. 

