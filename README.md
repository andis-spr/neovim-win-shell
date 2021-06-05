# neovim-qt-win-shell
!['Edit with Neovim' Windows Explorer directory right click context menu option being visible; Neovim Qt being associated with various text file types - indicated by program icon](https://github.com/andis-sprinkis/neovim-qt-win-shell/blob/media/preview.png)

Set Neovim Qt file type associations and add "Edit with Neovim" right click context menu item on Windows.

## Adding

- `config-nvim-qt-exe-path.txt` — put the full path of your `nvim-qt.exe` in the first line of this file.
- `config-file-type-associations.txt` — set the list of file name extensions that will be associated with Neovim Qt.

Run the `setup-ADD-nvim-qt-win-shell.cmd` script as an administrator to
 - register Neovim Qt `ProgID` and file associations
 - add the `Edit with Neovim` option to right-click context menu

## Removing
Run the `setup-REMOVE-nvim-qt-win-shell.cmd` script as an administrator to
- unregister Neovim Qt `ProgID` and file associations
- remove the `Edit with Neovim` option from right-click context menu

## General information

 - **Please be aware that on the first run the `nvim-qt-win-shell-ADD.bat` script downloads a third-party [SetUserFTA](https://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/) utility ZIP file from the author's homepage**, saving and extracting it in the same directory. It is used within the script for adding the file type associations to Windows Registry.

- It's advised NOT adding `.bat`, `.cmd`, `.vb` and `.vbs` file name extensions to `file-type-associations.txt`, as changing them will override Windows file opener default actions for these files, breaking various third-party scripts.
