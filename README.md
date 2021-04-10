# neovim-qt-win-shell
Set Neovim Qt as the default text editor on Windows (file associations, file & directory context menu item).

## Setup

Put the full path of your `nvim-qt.exe` executable as the first line of `nvim-qt-exe-path.txt`.

Optionally — edit the list of file extensions that will be associated with Neovim Qt in `file-associations.txt`.

Run `nvim-qt-win-shell-ADD.bat` to
- register Neovim Qt `ProgID`
- register Neovim Qt file associations
- add the `Edit with Neovim` file and directory right-click context menu item

## Removal
Run `nvim-qt-win-shell-REMOVE.bat` to
- unregister Neovim Qt `ProgID`
- unregister Neovim Qt file associations
- remove the `Edit with Neovim` file and directory right-click context menu item
