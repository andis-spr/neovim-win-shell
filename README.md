`/progid-nvim-qt/*.reg` adds or removes the `Applications/nvim-qt.exe` program ID to Windows Registry.

`/menu-edit-with-neovim/*.reg` adds or removes `Edit with Neovim` right click context menu item.

`set-associations.bat` + `associations.conf` associates the Neovim's program ID with every possible plaintext extension I could find.

IMPORTANT: Adjust `nvim-qt.exe` installation path in `.reg` files and the `associations.conf` list according to your setup and requirements before using them.

## Requirements

`set-associations.bat` requires the `setUserFTA` utility.
