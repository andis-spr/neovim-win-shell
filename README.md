`\set-progid-nvim-qt\*.reg` adds or removes the `Applications/nvim-qt.exe` program ID to Windows Registry.

`\set-context-menu-edit-with-neovim\*.reg` adds or removes `Edit with Neovim` right click file and directory context menu item.

`\set-file-assocations\set-associations.bat + associations-list.conf` associates the Neovim's program ID with a long list of plaintext file format extensions.

IMPORTANT: Adjust `nvim-qt.exe` installation path in `.reg` files and the `associations.conf` list according to YOUR setup and requirements before using them.

## Requirements

The `\set-file-associations\set-associations.bat` requires `setUserFTA` utility.
