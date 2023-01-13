# for Linux distro except nixos
## setup
1. setup nix environment
2. cd to this dir and execute following command
```
nix build .#homeConfigurations.tetsu.activationPackage
"$(nix path-info .#homeConfigurations.tetsu.activationPackage)"/activate
```
## update
1. update `home.nix` or `flake.nix`
2. stage changed files
3. execute following command
`home-manager switch --flake '.#tetsu'`
3.1. OR create link to `$HOME/.config/nixpkg` and then execute following command
`home-manager switch --flake`
