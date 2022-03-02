local nvim_lsp = require("lspconfig")
local protocol = require('vim.lsp.protocol')
local saga = require('lspsaga')

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

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
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_sync(nil, 8000)")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>r", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", {silent = true})
    buf_map(bufnr, "n", "<C-j>", ":Lspsaga show_line_diagnostics<CR>", {silent = true})
    buf_map(bufnr, "n", "gh", ":Lspsaga lsp_finder<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[d", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]d", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>f", ":LspFormatting<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {silent = true})

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
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


nvim_lsp.gopls.setup {
    cmd = { 'gopls', '--remote=auto'},
}

nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)

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
nvim_lsp.sumneko_lua.setup {
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
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

nvim_lsp.pyright.setup {
    on_attach = function(client)
        on_attach(client)
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

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
    javascript = "eslint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
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

local formatters = {
    prettier = {
      command = "npx",
      args = { "prettier", "--stdin-filepath", "%filepath" }
    },
    eslint_d = {
      command = "eslint_d",
      args = { "--stdin", "--fix-to-stdout", "--stdin-filename", "%filepath" },
    },
    -- black = { command = 'black --quiet -' }
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier",
    javascript = "prettier",
    json = "prettier",
    html = "prettier",
    css = "prettier",
    python = "black"
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- use .ts snippets in .tsx files
vim.g.vsnip_filetypes = {
    typescriptreact = {"typescript"}
}

require"compe".setup {
    preselect = "always",
    source = {
        path = true,
        buffer = true,
        vsnip = true,
        spell = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]()
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t("<Plug>(vsnip-expand-or-jump)")
    else
        return t("<Tab>")
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm("<CR>")]],
                        {expr = true, silent = true})
vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close("<C-e>")]],
                        {expr = true, silent = true})

-- vim.lsp.set_log_level("debug")
