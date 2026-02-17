# nvim

Personal Neovim config based on `kickstart.nvim`, with custom plugins and
workflows for LSP, Git, and terminal-first editing.

## Quick checks

Use these commands after config changes:

```sh
nvim --headless "+qa"
nvim --headless "+checkhealth" "+qa"
luac -p init.lua lua/custom/**/*.lua
```

## Git workflow keymaps

- `<leader>gg`: open Neogit UI
- `<leader>gd`: open Diffview
- `<leader>gD`: close Diffview
- `<leader>gf`: file history in Diffview (current file)
- `<leader>gF`: repository history in Diffview
- `<leader>h...`: hunk actions from Gitsigns (`:which-key <leader>h`)

## Backend workflow keymaps

These were added as additive mappings and do not replace existing behaviors.

### Diagnostics and code navigation

- `<leader>xx`: Trouble diagnostics view
- `<leader>xw`: Trouble workspace diagnostics
- `<leader>xd`: Trouble current buffer diagnostics
- `<leader>xq`: Trouble quickfix list
- `<leader>xl`: Trouble location list
- `<leader>tc`: toggle treesitter context header
- `<leader>jm` / `<leader>jk`: jump next/previous function start
- `<leader>jM` / `<leader>jK`: jump next/previous function end
- `<leader>jc` / `<leader>jC`: jump next/previous class start

### Testing and debugging

- `<leader>nr`: neotest run nearest
- `<leader>nf`: neotest run current file
- `<leader>ns`: neotest run suite (cwd)
- `<leader>nd`: neotest debug nearest (DAP)
- `<leader>nn`: neotest summary toggle
- `<leader>no`: neotest output
- `<leader>nO`: neotest output panel
- `<leader>na`: neotest attach
- `<leader>nS`: neotest stop

JS/TS debug support is provided by `nvim-dap-vscode-js` with `js-debug-adapter`.
C/C++ debug support is provided via `codelldb`.

### Project and file workflows

- `<leader>sR`: project search/replace via grug-far
- `<leader>eo`: open Oil file explorer view
- `<leader>cg`: CMake generate
- `<leader>cb`: CMake build
- `<leader>cr`: CMake run
- `<leader>ct`: CMake test
- `<leader>cc`: CMake select build type

## LSP notes

- Vue support uses `vue_ls` plus `ts_ls` scoped to `vue` filetypes.
- `ts_ls` is wired with `@vue/typescript-plugin`, so `vue_ls` can forward
  TypeScript requests in `.vue` buffers.
- `typescript-tools.nvim` remains available for TypeScript/JavaScript workflows.
- YAML LSP includes schema mappings for Kubernetes, Helm charts, Helmfile,
  and Kustomize.
- `helm_ls` is enabled for Helm templating workflows.

## Treesitter notes

- Uses the current API: `require('nvim-treesitter').setup()`.
- Config installs parsers from `ensure_installed` automatically when needed.

## Formatting and linting notes

- Conform formatters now cover JS/TS/JSON/YAML and C/C++.
- Linting includes markdown, Dockerfile (`hadolint`), and YAML (`yamllint`).

## Help docs

This repo ships a Vim help doc. After opening Neovim, run:

- `:help nvim-config`
