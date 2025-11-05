return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_no_formatters = true,
      formatters = {
        mdslw = {
          prepend_args = {
            "--max-width",
            "5000",
            "--features",
            "keep-linebreaks",
            "--suppressions",
            "!!!",
          },
        },
        mdformat = {
          prepend_args = {
            "--extensions",
            "mkdocs",
            "--align-semantic-breaks-in-lists",
          },
        },
      },
      formatters_by_ft = {
        graphql = { "prettierd" },
        hcl = { "keep-sorted", "tofu_fmt" },
        html = { "prettierd" },
        terraform = { "keep-sorted", "tofu_fmt" },
        ["terraform-vars"] = { "tofu_fmt" },
        tf = { "keep-sorted", "tofu_fmt" },
        toml = { "keep-sorted" },
      },
      default_format_opts = {
        lsp_format = "never",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.markdown = { "mdformat" }
      opts.formatters_by_ft.yaml = vim.list_extend(opts.formatters_by_ft.yaml or {}, { "keep-sorted", "yamlfmt" })
      opts.formatters_by_ft.json = vim.list_extend(opts.formatters_by_ft.json or {}, { "jq" })
      opts.formatters_by_ft.python = vim.list_extend(opts.formatters_by_ft.python or {}, { "isort", "black" })
      opts.formatters_by_ft.vue = vim.list_extend(opts.formatters_by_ft.json or {}, { "prettierd" })
      opts.formatters_by_ft.typescript = vim.list_extend(opts.formatters_by_ft.typescript or {}, { "prettierd" })
      opts.formatters_by_ft.javascript = vim.list_extend(opts.formatters_by_ft.javascript or {}, { "prettierd" })
    end,
  },
}
