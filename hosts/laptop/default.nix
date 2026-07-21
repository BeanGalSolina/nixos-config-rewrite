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
	 pkgsAug2025 = inputs.nixpkgs-august-2025.legacyPackages."x86_64-linux";
	 NixOSUtils = inputs.nixos-utils.nixosModules."x86_64-linux";
	 nixModules = self.nixosModules;
	 homeModules = self.homeModules;
	 isGui = true;
	 isGaming = true;
      };
   in {
      laptop = lib.nixosSystem {
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

