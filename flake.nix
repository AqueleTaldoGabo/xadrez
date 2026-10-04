{
  description = "Ambiente Flutter Estável e Flexível";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            flutter
            android-studio 
            jdk21
            fvm
          ];
          GRADLE_OPTS = "-Dorg.gradle.project.buildDir=build";
          shellHook = ''
            export ANDROID_HOME="$HOME/Android/Sdk"
            export ANDROID_USER_HOME="$HOME/.android"
            export ANDROID_AVD_HOME="$HOME/.android/avd"
            export JAVA_HOME="${pkgs.jdk21.home}"
            
            export QT_QPA_PLATFORM="xcb"
            
            export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"
            
            
            
            echo "Ambiente mobile carregado!"
          '';
        };
      });
}
