return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  cmd = "CopilotChat",
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      window = {
        width = 0.4,
      },
    }
  end,
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      function()
        return require("CopilotChat").toggle({ sticky = { "#buffer" } })
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then
            require("CopilotChat").ask(input, { sticky = { "#buffer" } })
          end
        end)
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ae",
      function()
        require("CopilotChat").ask("Explain this code")
      end,
      desc = "Explains Code (CopilotChat)",
      mode = { "v" },
    },
    {
      "<leader>ar",
      function()
        require("CopilotChat").ask("Review this code")
      end,
      desc = "Reviews Code (CopilotChat)",
      mode = { "v" },
    },
    {
      "<leader>af",
      function()
        require("CopilotChat").ask("Fix this code")
      end,
      desc = "Fix Code (CopilotChat)",
      mode = { "v", "n" },
    },
    {
      "<leader>ao",
      function()
        require("CopilotChat").ask("Optimize this code")
      end,
      desc = "Optimize Code (CopilotChat)",
      mode = { "v", "n" },
    },
    {
      "<leader>al",
      function()
        require("CopilotChat").ask("Add logging to this code")
      end,
      desc = "Adds logs to Code (CopilotChat)",
      mode = { "v" },
    },
  },
  config = function(_, opts)
    local chat = require("CopilotChat")

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
}
