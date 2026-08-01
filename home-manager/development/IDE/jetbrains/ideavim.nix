# ideavim.nix – Home Manager module for IdeaVim (vim emulation in JetBrains IDEs)
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.development.IDE.jetbrains.ideavim.enable = lib.mkEnableOption "Enables IdeaVim configuration";

  config = lib.mkMerge [
    # Lock ideavim to false when no JetBrains IDE is enabled
    (lib.mkIf (!config.development.IDE.jetbrains.intellij.enable && !config.development.IDE.jetbrains.android-studio.enable) {
      development.IDE.jetbrains.ideavim.enable = lib.mkForce false;
    })
    # Apply config when ideavim is enabled
    (lib.mkIf config.development.IDE.jetbrains.ideavim.enable {
      home.file.".ideavimrc" = {
        text = ''
          Plug 'tpope/vim-commentary'
          set clipboard+=unnamedplus
          let mapleader = " "
          set which-key
          set visualbell
          set noerrorbells
          set number relativenumber

          nnoremap <C-w> :action HideActiveWindow<CR>
          nnoremap <leader>fa :action FindInPath<CR>
          nnoremap <leader>ff :action GotoFile<CR>
          nnoremap <leader>fh :action GotoAction<CR>

          nnoremap <C-Tab> :action NextTab<CR>
          nnoremap <C-S-Tab> :action PreviousTab<CR>
          nnoremap <C-w> :action CloseContent<CR>

          nnoremap <C-s> :action SaveAll<CR>

          nnoremap <leader>cr :action FindUsages<CR>
          nnoremap <leader>ca :action ShowIntentionActions<CR>
          nnoremap <leader>ce :action GotoError<CR>
          nnoremap <leader>cs :action ShowErrorDescription<CR>
          nnoremap <leader>cd :action GotoDeclaration<CR>
          nnoremap <leader>ci :action GotoImplementation<CR>

          nnoremap <leader>cf :action GotoSymbol<CR>

          nnoremap <leader>fi :action Find<CR>

          nnoremap <leader>cq :action GotoNextError<CR>

          nnoremap <leader><Tab> :action RecentFiles<CR>
          inoremap <C-p> <C-P>
          inoremap <C-n> <C-N>
        '';
      };
    })
  ];
}
