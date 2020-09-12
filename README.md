`progid-nvim-qt` adds / removes the `Applications/nvim-qt.exe` programid to Windows Registry.

`menu-edit-with-neovim` adds / removes 'Edit with Neovim` right click context menu item.

`set-associations.bat` + `associations.conf` associates the Neovim's programid with every possible plaintext format extension I could find.

Do adjust `nvim-qt.exe` path in `.reg` files and the `associations.conf` list according to your setup and requirements before using them.

## Requirements

Setting file associations requires the `setUserFTA` utility.
