return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- lint.linters.golangcilint = {
      --   cmd = 'golangci-lint',
      --   name = 'golangcilint',
      --   stdin = false,
      --   args = { 'run', '--out-format', 'json', '.' }, -- run on entire package
      --   stream = 'stdout',
      --   ignore_exitcode = true,
      --   parser = function(output, bufnr)
      --     local diagnostics = {}
      --     local ok, decoded = pcall(vim.json.decode, output)
      --     if not ok or not decoded or not decoded.Issues then
      --       return diagnostics
      --     end
      --
      --     local current_file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p')
      --
      --     for _, issue in ipairs(decoded.Issues) do
      --       local filepath = vim.fn.fnamemodify(issue.Pos.Filename, ':p')
      --       if filepath:sub(-#current_file) == current_file then
      --         table.insert(diagnostics, {
      --           lnum = issue.Pos.Line - 1,
      --           col = math.max(issue.Pos.Column - 1, 0),
      --           end_lnum = issue.Pos.Line - 1,
      --           end_col = issue.Pos.Column,
      --           severity = vim.diagnostic.severity.WARN,
      --           message = issue.Text,
      --           source = 'golangci-lint',
      --         })
      --       end
      --     end
      --
      --     return diagnostics
      --   end,
      -- }
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        terraform = { 'tflint' },
        json = { 'jsonlint' },
        go = { 'golangcilint' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
