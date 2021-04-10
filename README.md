# neovim-qt-win-shell
![Screenshot demonstrating 'Edit with Neovim' Windows Explorer directory right click context menu item and Neovim Qt being associated with various text files.](https://i.imgur.com/SE9ia2U.png)

Set Neovim Qt as the default text editor on Windows (Explorer file associations, file & directory context menu item).
## Setup

Put the full path of your `nvim-qt.exe` executable as the first line of `nvim-qt-exe-path.txt`.

Optionally — edit the list of file extensions that will be associated with Neovim Qt in `file-associations.txt`.

---
It's advised NOT changing `.bat`, `.cmd`, `.vb` and `.vbs` file extension default program associations as it will override Windows file opener default actions for these files, breaking various third-party scripts.

---

Run `nvim-qt-win-shell-ADD.bat` as administrator to
- register Neovim Qt `ProgID`
- register Neovim Qt file associations
- add the `Edit with Neovim` file and directory right-click context menu item

## Removal
Run `nvim-qt-win-shell-REMOVE.bat` as administrator to
- unregister Neovim Qt `ProgID`
- unregister Neovim Qt file associations
- remove the `Edit with Neovim` file and directory right-click context menu item
