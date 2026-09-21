{
   self,
   inputs,
   ...
}: {
   flake.nixosConfigurations = let
      inherit (inputs.nixpkgs) lib;
      sys-modules = "${self}/sys-modules";
      packages = "${self}/packages";
      specialArgs = {
         inherit inputs self sys-modules packages;
	 pkgsLibreoffice = inputs.nixpkgs-libreoffice.legacyPackages."x86_64-linux";
	 pkgsAug2025 = inputs.nixpkgs-august-2025.legacyPackages."x86_64-linux";
	 NixOSUtils = inputs.nixos-utils.nixosModules."x86_64-linux";
	 isGui = true;
	 isGaming = true;
	 nixModules = self.nixosModules;
	 homeModules = self.homeModules;
         
         #pkgsPatched = import inputs.nixpkgs {
         #   config.allowUnfree = true;
         #   system = "x86_64-linux";
         #   patches = [
         #      (inputs.nixpkgs.lib.fetchpatch {
         #         url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/450049.patch";
         #         hash = "";
         #      })
         #   ];
         #};
      };
   in {
      desktop = lib.nixosSystem {
         inherit specialArgs;
         modules = [
            "${sys-modules}/system/boot/grub"
            "${sys-modules}/system/boot/efi"

            "${sys-modules}/system/users/solina"

            "${sys-modules}/bases/gaming"

            ./hardware-configuration.nix
            ./config.nix
            
            inputs.home-manager.nixosModules.home-manager
            inputs.catppuccin.nixosModules.catppuccin
            { home-manager.extraSpecialArgs = specialArgs; }
         ];
      };
   };
}

