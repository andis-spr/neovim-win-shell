Set Neovim Qt as the default text editor in Windows

# Pre-setup
- set your `nvim-qt.exe` installation path in `set-progid-nvim-qt\*.reg` and `set-context-menu-edit-with-neovim\*.reg`
- install [`setUserFTA`](https://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/) which is required for setting file associations
- adjust the file types that will be associated with Neovim Qt in `set-file-associations\associations-list.conf`

# Setup
1. Apply `set-progid-nvim-qt\*.reg` registry keys to register or unregister the `Applications\nvim-qt.exe` program ID
2. Apply `set-context-menu-edit-with-neovim\*.reg` registry keys to add or remove the `Edit with Neovim` right click directory and file context menu item
3. Run `set-file-assocations\set-associations.bat` to associate Neovim Qt with a long list of text file extensions
