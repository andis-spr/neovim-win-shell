# neovim-qt-win-shell
Set Neovim Qt as the default text editor on Windows (file associations, context menu item).

## Pre-setup

Put path of your `nvim-qt.exe` file as the first line of `nvim-qt-exe-path.txt`.

### Optional
Edit the list of file extensions that will be associated with Neovim Qt in `nvim-qt-file-associations.txt`.

## Usage
### Set
Run `nvim-qt-win-shell-SET.bat` to
- set Neovim Qt `ProgID`
- set Neovim Qt file associations
- set `Edit with Neovim` file and directory context menu item

### Unset
Run `nvim-qt-win-shell-UNSET.bat` to
- unset Neovim Qt `ProgID`
- unset Neovim Qt file associations
- unset `Edit with Neovim` file and directory context menu item
