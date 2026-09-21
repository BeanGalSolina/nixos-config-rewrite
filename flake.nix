{
	description = "Description for the project";

	inputs = {
		catppuccin = {
			url = "github:catppuccin/nix";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		nixos-utils = {
			url = "github:TheBunnyMan123/NixosUtils";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		flake-parts.url = "github:hercules-ci/flake-parts";
		hardware.url = "github:nixos/nixos-hardware";
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nixpkgs-august-2025.url = "github:NixOS/nixpkgs/1c3b10e04b7ff1948b5a3eda3d33547506fb8fee";
		nixpkgs-libreoffice.url = "github:NixOS/nixpkgs/3497aa5c9457a9d88d71fa93a4a8368816fbeeba";
	};

	outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
		imports = [
			./hosts
			./nix-modules
		];

		systems = [ "x86_64-linux" ];
	};
}
