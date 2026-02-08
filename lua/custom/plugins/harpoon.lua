return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      default = {
        select = function(list_item, _, options)
          if not list_item or not list_item.value or list_item.value == '' then
            return
          end

          options = options or {}
          local open_cmd = 'edit'
          if options.vsplit then
            open_cmd = 'vsplit'
          elseif options.split then
            open_cmd = 'split'
          elseif options.tabedit then
            open_cmd = 'tabedit'
          end

          vim.cmd(open_cmd .. ' ' .. vim.fn.fnameescape(list_item.value))

          local context = list_item.context or {}
          local row = math.max(1, tonumber(context.row) or 1)
          local col = math.max(0, tonumber(context.col) or 0)
          local line_count = vim.api.nvim_buf_line_count(0)
          if line_count < 1 then
            return
          end

          if row > line_count then
            row = line_count
          end

          local row_text = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ''
          if col > #row_text then
            col = #row_text
          end

          pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
        end,
      },
    }

    vim.keymap.set('n', '<leader>a', function()
      if vim.bo.buftype ~= '' then
        vim.notify('Harpoon: current buffer is not a file', vim.log.levels.INFO)
        return
      end
      harpoon:list():add()
    end, { desc = 'Harpoon add' })
    vim.keymap.set('n', '<leader>hm', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon menu' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon menu' })
    vim.api.nvim_create_user_command('HarpoonMenu', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle Harpoon quick menu' })

    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
  end,
}
