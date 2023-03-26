{ config, pkgs, lib, ... }:

let
  skkeleton-config = ''
    function! s:skkeleton_init() abort
    call skkeleton#config({
      \ 'globalJisyo': "${pkgs.skk-dicts}/share/SKK-JISYO.L",
      \ 'globalJisyoEncoding': 'utf-8',
      \ })
    call skkeleton#register_kanatable('rom', {
      \ "z\<Space>": ["\u3000", ""],
      \ })
    endfunction

    augroup skkeleton-initialize-pre
    autocmd!
    autocmd User skkeleton-initialize-pre call s:skkeleton_init()
    augroup END

    imap <C-j> <Plug>(skkeleton-toggle)
    cmap <C-j> <Plug>(skkeleton-toggle)
  '';
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tetsu";
  home.homeDirectory = "/home/tetsu";

  # install package from pkgs
  home.packages = [
    pkgs.sl
    pkgs.bat
    pkgs.delta
    pkgs.nixpkgs-fmt
    pkgs.skk-dicts
    pkgs.rustc
    pkgs.cargo
    pkgs.fzf
    pkgs.deno
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ignore experimental-features warnings
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  # install program from home-manager repository's config
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      tree-sitter
      clang
      deno
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      vim-nix
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          lua << EOF
          require'nvim-treesitter.configs'.setup {
            parser_install_dir = '~/.local/share/nvim/site',
            highlight = {
              enable = true,
              --disable = { "ruby", "python" }
            },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
              },
              --disable = { "ruby", "python" }
            },
            indent = {
              enable = true ,
              --disable = { "ruby", "python" }
            },
            textobjects = {
              enable = true,
              --disable = { "ruby", "python" }
            },
          }
          EOF
        '';
      }
      nvim-treesitter-context
      vista-vim
      denops
      {
        plugin = skkeleton;
        config = skkeleton-config;
      }
      {
        plugin = fern-vim;
        config = ''
          let g:fern#renderer = "nerdfont"
          command Fernr Fern . -reveal=%
          command Fernd Fern %:h
          command Ferndr Fern %:h -reveal=%
          command Fernb Fern bookmark:///

          function! s:fern_init() abort
            " Open bookmark:///
            nnoremap <buffer><silent>
                  \ <Plug>(fern-my-enter-bookmark)
                  \ :<C-u>Fern bookmark:///<CR>
            nmap <buffer><expr><silent>
                  \ <C-^>
                  \ fern#smart#scheme(
                  \   "\<Plug>(fern-my-enter-bookmark)",
                  \   {
                  \     'bookmark': "\<C-^>",
                  \   },
                  \ )
          endfunction

          function! s:fern_settings() abort
            nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
            nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
            nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
            nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
          endfunction

          augroup fern-settings
            autocmd!
            autocmd FileType fern call s:fern_settings()
          augroup END

        '';
      }
      vim-devicons
      nvim-web-devicons
      nerdfont
      fern-renderer-nerdfont
      fern-git-status
      fern-mapping-git
      fern-hijack
      fern-bookmark
      fern-mapping-quickfix
      fern-preview
      gina-vim
      quickrun
      indentLine
      tabular
      comment-nvim
      undotree
      {
        plugin = sonokai;
        config = ''
          colorscheme sonokai
        '';
      }
      {
        plugin = dial-nvim;
        config = ''
          nmap <C-a> <Plug>(dial-increment)
          nmap <C-x> <Plug>(dial-decrement)
          vmap <C-a> <Plug>(dial-increment)
          vmap <C-x> <Plug>(dial-decrement)
          vmap g<C-a> <Plug>(dial-increment-additional)
          vmap g<C-x> <Plug>(dial-decrement-additional)
        '';
      }
      {
        plugin = vim-markdown;
        config = ''
          let g:vim_markdown_folding_disabled = 1
          let g:vim_markdown_conceal_code_blocks = 0
          let g:vim_markdown_conceal = 0
          let g:vim_markdown_new_list_item_indent = 0
        '';
      }
      {
        plugin = vim-airline;
        config = ''
          " タブラインの表示
          let g:airline#extensions#tabline#enabled = 1
          " （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
          " let g:airline#extensions#tabline#show_buffers = 0
          " 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
          let g:airline#extensions#tabline#tab_nr_type = 1
          " パワーラインフォントの使用
          let g:airline_powerline_fonts = 1
          " Do not collapse the status line while having multiple windows
          let g:airline_inactive_collapse = 0
          " tagbarの表示
          " let g:airline#extensions#tagbar#enabled = 1
          let g:airline#extensions#vista#enabled = 1
          " virtualenvを有効
          let g:airline#extensions#virtualenv#enabled = 1
          let g:airline_section_c = airline#section#create(['%t%m'])
          let g:airline_section_z = airline#section#create(['%p%% ☰ %l/%L :%v'])
          " aleの出力をairline表示
          " let g:airline#extensions#ale#enabled = 1
          let g:airline#extensions#lsp#enabled = 0
        '';
      }
      vim-airline-themes
      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
          local keyopts = { noremap=true, silent=true }

          vim.keymap.set('n', '<leader>T',   '<cmd>Telescope<cr>', keyopts)
          vim.keymap.set('n', '<leader>tf ', '<cmd>Telescope find_files<cr>', keyopts)
          vim.keymap.set('n', '<leader>tlg', '<cmd>Telescope live_grep<cr>', keyopts)
          vim.keymap.set('n', '<leader>tb ', '<cmd>Telescope buffers<cr>', keyopts)
          vim.keymap.set('n', '<leader>to ', '<cmd>Telescope oldfiles<cr>', keyopts)
          vim.keymap.set('n', '<leader>th ', '<cmd>Telescope help_tags<cr>', keyopts)
          vim.keymap.set('n', '<leader>tr ', '<cmd>Telescope lsp_references<cr>', keyopts)
          vim.keymap.set('n', '<leader>tc ', '<cmd>Telescope lsp_code_actions<cr>', keyopts)
          vim.keymap.set('n', '<leader>tgc', '<cmd>Telescope git_commits<cr>', keyopts)
          vim.keymap.set('n', '<leader>tgb', '<cmd>Telescope git_branches<cr>', keyopts)
          vim.keymap.set('n', '<leader>tgs', '<cmd>Telescope git_status<cr>', keyopts)
          vim.keymap.set('n', '<leader>tsp', '<cmd>Telescope spell_suggest<cr>', keyopts)
          --
          require('telescope').setup({
            extensions = {
              fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              }
            }
          })
          -- To get fzf loaded and working with telescope, you need to call
          -- load_extension, somewhere after setup function:
          require('telescope').load_extension('fzf')
          EOF
        '';
      }
      telescope-fzf-native-nvim
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          require('mason').setup({})

          -- Aerial config
          -- local aerial = require('aerial')
          -- aerial.setup({})

          -- local saga = require('lspsaga')
          -- saga.init_lsp_saga()

          -- Setup lspconfig with nvim-cmp
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

          -- diagnosticのマッピング
          local keyopts = { noremap=true, silent=true }
          vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, keyopts)
          vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, keyopts)
          vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, keyopts)
          vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, keyopts) -- locationlistにdiagnosticの

          local custom_attach = function(client, bufnr)
            -- aerial.on_attach(client, bufnr)
            --require'completion'.on_attach()

            -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]])

            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            --
            -- Aerial does not set any mappings by default, so you'll want to set some up
            -- Toggle the aerial pane with <leader>a
            vim.keymap.set('n', '<leader>a', function() aerial.toggle(false, ">") end, bufopts)
            -- Jump forwards/backwards with '[[' and ']]'
            -- vim.keymap.set('n', '[[', aerial.prev_item, bufopts)
            -- vim.keymap.set('v', '[[', aerial.prev_item, bufopts)
            -- vim.keymap.set('n', ']]', aerial.next_item, bufopts)
            -- vim.keymap.set('v', ']]', aerial.next_item, bufopts)

            -- This is a great place to set up all your other LSP mappings
            -- aerial.set_filter_kind{
            --   'Function',
            --   'Class',
            --   'Constructor',
            --   'Method',
            --   'Struct',
            --   'Enum',
            --   'Field',
            -- }

            -- helpのexampleキーマップ
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gtd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)


            -- 追加キーマップ
            -- vim.keymap.set('n', '<leader><c-]>', vim.buf.peek_definition, bufopts)

            -- コマンド追加
            vim.api.nvim_buf_create_user_command(bufnr, "LspDeclaration", vim.lsp.buf.declaration, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspDefinition", vim.lsp.buf.definition, {})
            -- vim.api.nvim_buf_create_user_command(bufnr, "LspPeekDefinition", vim.lsp.buf.peek_definition, {})
            vim.api.nvim_buf_create_user_command(bufnr, "Lsphover", vim.lsp.buf.hover, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspImpletentation", vim.lsp.buf.implementation, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", vim.lsp.buf.code_action, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.format, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspShowLineDiagnostivs", vim.diagnostic.open_float, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspAddWorkspaceFolder", function() vim.lsp.buf.add_workspace_folder() end, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
            vim.api.nvim_buf_create_user_command(bufnr, "LspListWorkspaceFolder", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
          end
          ----------------

          require'lspconfig'.gopls.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          require'lspconfig'.solargraph.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          require'lspconfig'.vimls.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          require'lspconfig'.tsserver.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          require'lspconfig'.vuels.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          require'lspconfig'.yamlls.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }
          -- require'lspconfig'.pyright.setup{
          --   on_attach = custom_attach,
          -- }
          require'lspconfig'.dockerls.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }

          require'lspconfig'.rnix.setup{
            on_attach = custom_attach,
            capabilities = capabilities
          }

          -- for rust
          require('rust-tools').setup({
            on_attach = custom_attach,
            server = {
              cargo = {
                loadOutDirsFromCheck = true
              }
            },
            capabilities = capabilities
          })
          EOF
        '';
      }
      mason-nvim
      rust-tools-nvim
      {
        plugin = nvim-cmp;
        config = ''
          lua << EOF
          vim.opt.completeopt = {'menu','menuone','noselect'}

          local cmp = require'cmp'

          cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_document_symbol' },
                { name = 'tabnine' },
                { name = 'skkeleton' },
                { name = 'treesitter' },
                { name = 'buffer' },
                { name = 'path' },
              },{
                { name = 'buffer' }
              }),

          })

          -- Set configuration for specific filetype.
          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
              { name = 'buffer' },
            })
          })

          cmp.setup.filetype('lua', {
            sources = cmp.config.sources({
              { name = 'nvim_lua' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
              { name = 'buffer' },
            })
          })

          -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' },
              {
                name = 'cmdline_history',
                option = { history_type = '/' }
              }
            }
          })

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' },
              {
                name = 'cmdline_history',
                option = { history_type = ':' }
              }
            }, {
              { name = 'cmdline' }
            })
          })
          EOF
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lua
      cmp-nvim-lsp-document-symbol
      cmp-git
      #cmp-tabnine
      cmp-treesitter
      cmp-skkeleton
      {
        plugin = vimdoc-ja;
        config = ''
          set helplang=ja,en
        '';
      }
      back-and-forward
    ];
    extraConfig = ''
      noremap <Space> <Nop>
      let g:mapleader = "\<Space>"
      let g:maplocalleader = "\\"

      " terminal mappling
      tnoremap <C-w><C-w> <C-\><C-n>
      tnoremap <C-w>h <C-\><C-n><C-w>h
      tnoremap <C-w>k <C-\><C-n><C-w>k
      tnoremap <C-w>j <C-\><C-n><C-w>j
      tnoremap <C-w>l <C-\><C-n><C-w>l

      nnoremap <silent> gb :b#<CR>
      cmap <expr> D<TAB> expand('%:h')
      nunmap Y

      command -nargs=? E Explore <args>

      set fenc=utf-8
      set undofile
      " コマンドラインの補完
      set wildmode=list:longest
      "コードの色分けはtreesitterに
      syntax off
      set scrolloff=3
      set list listchars=tab:\▸\-

      set ignorecase
      set smartcase
      " 検索文字列入力時に順次対象文字列にヒットさせる
      set incsearch
      " 検索時に最後まで行ったら最初に戻る
      set wrapscan
      " 検索語をハイライト表示
      set hlsearch
      " ESC連打でハイライト解除
      nmap <Esc><Esc> :nohlsearch<CR><Esc>
      " 置換時候補をインタラクティブに表示
      set inccommand=split
      set sw=2
      " vimgrepでquickfixを開く
      autocmd QuickFixCmdPost *grep* cwindow

      " Focus floating window with <C-w><C-w> {{{
      if has('nvim')
      function! s:focus_floating() abort
      if !empty(nvim_win_get_config(win_getid()).relative)
      wincmd p
      return
      endif
      for winnr in range(1, winnr('$'))
      let winid = win_getid(winnr)
      let conf = nvim_win_get_config(winid)
      if conf.focusable && !empty(conf.relative)
        call win_gotoid(winid)
        return
      endif
      endfor
      endfunction
      nnoremap <silent> <C-w><C-w> :<C-u>call <SID>focus_floating()<CR>
      endif
    '';
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      committia-vim
      skkeleton
      denops
    ];
    extraConfig = ''
    ${skkeleton-config}
    set fenc=utf-8
    set encoding=utf-8
    '';
  };
  #  programs.zsh = {
  #    enable = true;
  #    enableAutosuggestions = true;
  #    enableSyntaxHighlighting = true;
  #    defaultKeymap = "emacs";
  #    initExtra = ''
  #autoload -Uz vcs_info
  #setopt prompt_subst
  #zstyle ':vcs_info:*' formats '[%F{green}%b%f]'    
  #zstyle ':vcs_info:*' actionformats '%F{green}%b%f(%F{red}%a%f)' 
  #precmd() { vcs_info }
  #
  ## 時刻を表示したい
  #export PREV_COMMAND_END_TIME
  #export NEXT_COMMAND_BGN_TIME
  #
  #function show_command_end_time() {
  #PREV_COMMAND_END_TIME=`date "+%H:%M:%S"`
  #PROMPT="%F{blue}''${HOST}%f
  #Dir: %F{red}%~%f ''${vcs_info_msg_0_}
  #''${PREV_COMMAND_END_TIME} - __:__:__
  #%F{red}$%f "
  #}
  #autoload -Uz add-zsh-hook
  #add-zsh-hook precmd show_command_end_time
  #
  #show_command_begin_time() {
  #NEXT_COMMAND_BGN_TIME=`date "+%H:%M:%S"`
  #PROMPT="%F{blue}''${HOST}%f
  #Dir: %F{red}%~%f ''${vcs_info_msg_0_}
  #''${PREV_COMMAND_END_TIME} - ''${NEXT_COMMAND_BGN_TIME} 
  #$ "
  #zle .accept-line
  #zle .reset-prompt
  #}
  #zle -N accept-line show_command_begin_time
  #
  #export CLICOLOR=1
  #export LSCOLORS=DxGxcxdxCxegedabagacad
  #
  ##コマンド履歴検索(CTRL + P,N)
  #autoload history-search-end
  #zle -N history-beginning-search-backward-end history-search-end
  #zle -N history-beginning-search-forward-end history-search-end
  #bindkey "^P" history-beginning-search-backward-end
  #bindkey "^N" history-beginning-search-forward-end
  #
  #if [ -e /home/tetsu/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tetsu/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
  #'';
  #  };

  programs.git = {
    enable = true;
    userName = "tksgi";
    userEmail = "23550705+tksgi@users.noreply.github.com";
    aliases = {
      co = "checkout";
      bt = "branch";
      st = "status";
      delete-merged-branches = "!git branch --merged | grep -vE '^\\*|master$|develop$' | xargs -I % git branch -d %";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
      };
    };
    ignores = [
      "*~"
      ".DS_Store"
      "ctags"
      "GTAGS"
      "GPATH"
      "GRTAGS"
      "Session.vim"
      "memo.md"
    ];
    extraConfig = {
      core = {
        editor = "vim";
      };
    };
  };
}
