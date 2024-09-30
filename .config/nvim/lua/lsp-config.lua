local nvim_lsp = require("lspconfig")
local util = require 'lspconfig.util'
local protocol = require('vim.lsp.protocol')
-- local saga = require('lspsaga')

-- saga.init_lsp_saga {
--   error_sign = '',
--   warn_sign = '',
--   hint_sign = '',
--   infor_sign = '',
--   border_style = "round",
-- }

vim.api.nvim_command('hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red')
vim.api.nvim_command('hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow')
vim.api.nvim_command('hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White')
vim.api.nvim_command('hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White')

-- Underline the offending code
vim.api.nvim_command('hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline')
vim.api.nvim_command('hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline')
vim.api.nvim_command('hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline')
vim.api.nvim_command('hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
 }
)

vim.lsp.diagnostic.error_sign = '⨷'
vim.lsp.diagnostic.warn_sign = '⚠'

-- vim.api.nvim_command("autocmd CursorHold * "..vim.lsp.diagnostic.show_line_diagnostics())

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.format()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspFloat lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>r", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", {silent = true})
    buf_map(bufnr, "n", "<C-j>", ":LspFloat<CR>", {silent = true})
    buf_map(bufnr, "n", "gh", ":Lspsaga lsp_finder<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[d", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]d", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>f", ":LspFormatting<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {silent = true})

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_exec2([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> LspFormatting
         augroup END
         ]], {output=true})
    end

    protocol.CompletionItemKind = {
      '';   -- Text          = 1;
      '';   -- Method        = 2;
      'ƒ';   -- Function      = 3;
      '';   -- Constructor   = 4;
      '識';  -- Field         = 5;
      '';   -- Variable      = 6;
      '';   -- Class         = 7;
      'ﰮ';   -- Interface     = 8;
      '';   -- Module        = 9;
      '';   -- Property      = 10;
      '';   -- Unit          = 11;
      '';   -- Value         = 12;
      '了';  -- Enum          = 13;
      '';   -- Keyword       = 14;
      '﬌';   -- Snippet       = 15;
      '';   -- Color         = 16;
      '';   -- File          = 17;
      '渚';  -- Reference     = 18;
      '';   -- Folder        = 19;
      '';   -- EnumMember    = 20;
      '';   -- Constant      = 21;
      '';   -- Struct        = 22;
      '鬒';  -- Event         = 23;
      'Ψ';   -- Operator      = 24;
      '';   -- TypeParameter = 25;
    }
end

nvim_lsp.prismals.setup {}


nvim_lsp.gopls.setup {
    cmd = { 'gopls', '--remote=auto'},
}

nvim_lsp.ts_ls.setup {
    root_dir = util.root_pattern('.git'),
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false

        local navic = require("nvim-navic")
        navic.attach(client, bufnr)

        on_attach(client, bufnr)

        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup({})

        ts_utils.setup_client(client)

        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", opts)
    end
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

nvim_lsp.pyright.setup {
    on_attach = function(client, bufnr)
      local navic = require("nvim-navic")
      navic.attach(client, bufnr)
      on_attach(client, bufnr)
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        },
        venvPath = './',
        venv = 'env'
      },
    },
    single_file_support = true
}

nvim_lsp.theme_check.setup {}

nvim_lsp.jsonls.setup{
  provideFormatter = true
}

nvim_lsp.eslint.setup({
  settings = {
    enable = true
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
    javascript = "eslint",
    liquid = "eslint"
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", ".eslintrc.json", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}

nvim_lsp.tailwindcss.setup{
  settings = {
    tailwindCSS = {
      validate = true,
      rootFontSize = 16, -- Change when working on different project
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
    },
  },
}


local formatters = {
    prettier = {
      command = "npx",
      args = { "prettier", "--stdin-filepath", "%filepath" }
    },
    -- eslint_d = {
    --   command = "eslint_d",
    --   args = { "--stdin", "--fix-to-stdout", "--stdin-filename", "%filepath" },
    -- },
    -- black = { command = 'black --quiet -' }
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier",
    javascript = "prettier",
    liquid = "prettier",
    json = "prettier",
    html = "prettier",
    css = "prettier",
    svg = "prettier",
    python = "black"
}

-- vim.lsp.set_log_level("TRACE")

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        -- linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- use .ts snippets in .tsx files
vim.g.vsnip_filetypes = {
    typescriptreact = {"typescript"}
}

-- vim.lsp.set_log_level("debug")
