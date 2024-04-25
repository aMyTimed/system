{ config, pkgs, ... }:

{

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = [
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.svelte.svelte-vscode
        pkgs.vscode-extensions.tamasfe.even-better-toml
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.dart-code.flutter

        pkgs.vscode-extensions.rust-lang.rust-analyzer
    ];
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "workbench.editor.enablePreview" = false;
      "editor.formatOnSave" = true;
      "svelte.enable-ts-plugin" = true;
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
        "scminput" = false;
      };
      "window.zoomLevel" = -2;
    };
    mutableExtensionsDir = false;
  };

  # Custom product.json so GitHub Copilot works on VSCodium
  # Since it's in xdg config, its just overrides for the VSCodium product.json and not a full replacement
  xdg.configFile."VSCodium/product.json".source = ./product.json;

}
