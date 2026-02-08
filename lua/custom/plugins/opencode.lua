return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'snacks',
        snacks = {
          auto_close = false,
          win = {
            position = 'right',
            border = 'rounded',
            width = math.floor(vim.o.columns * 0.35),
            enter = false,
          },
        },
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
    vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Execute opencode action…' })
    local function opencode_toggle()
      local ok, err = pcall(function()
        require('opencode').toggle()
      end)
      if not ok then
        vim.notify('opencode toggle failed: ' .. tostring(err), vim.log.levels.ERROR)
      end
    end

    vim.keymap.set({ 'n', 't' }, '<C-.>', opencode_toggle, { desc = 'Toggle opencode' })
    vim.keymap.set('n', '<leader>oc', opencode_toggle, { desc = 'Toggle opencode chat' })

    local opencode_term_nav_group = vim.api.nvim_create_augroup('opencode-term-nav', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = opencode_term_nav_group,
      pattern = 'opencode_terminal',
      callback = function(ev)
        local function tmux_nav(cmd)
          local esc = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
          vim.api.nvim_feedkeys(esc, 'n', false)
          vim.cmd(cmd)
        end

        vim.keymap.set('t', '<C-h>', function()
          tmux_nav 'TmuxNavigateLeft'
        end, { buffer = ev.buf, silent = true, desc = 'Tmux navigate left from opencode' })

        vim.keymap.set('t', '<C-j>', function()
          tmux_nav 'TmuxNavigateDown'
        end, { buffer = ev.buf, silent = true, desc = 'Tmux navigate down from opencode' })

        vim.keymap.set('t', '<C-k>', function()
          tmux_nav 'TmuxNavigateUp'
        end, { buffer = ev.buf, silent = true, desc = 'Tmux navigate up from opencode' })

        vim.keymap.set('t', '<C-l>', function()
          tmux_nav 'TmuxNavigateRight'
        end, { buffer = ev.buf, silent = true, desc = 'Tmux navigate right from opencode' })
      end,
    })

    vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Add range to opencode', expr = true })
    vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Add line to opencode', expr = true })

    vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll opencode down' })

    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
  end,
}
