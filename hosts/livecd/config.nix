{
	pkgs,
	lib,
	config,
	home-modules,
	...
}: {
	isoImage.squashfsCompression = "gzip -Xcompression-level 1";
	isoImage.edition = lib.mkForce "solinaconf";
	networking.hostName = "NixOS-LiveCD";
	fonts.fontconfig.enable = lib.mkForce true;
	home-manager.useGlobalPkgs = true;

	nixpkgs.hostPlatform = "x86_64-linux";
	networking.networkmanager.enable = lib.mkForce false;

	services.getty.autologinUser = lib.mkForce "solina";

	environment.systemPackages = with pkgs; [
		coreutils-full
		git
		fastfetch
		github-cli
		neovim
		fzf
		eza
		rcs
		bat
		w3m
		rofi
		waybar
		grim
		slurp
		wl-clipboard
		hypridle
		grimblast
	];

	systemd.services.nixos-config = if builtins.pathExists "${../..}/.git" then {
		description = "Copy NixOS config to /etc/nixos";
		after = ["local-fs.target" "multi-user.target"];
		requiredBy = [ "default.target" ];

		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
		};

		script = ''
			mkdir -p /etc/nixos
			cp -rT "${../..}" /etc/nixos
			chmod 777 /etc/nixos -R
			chown -R root:root /etc/nixos
			rm -f /etc/nixos/configuration.nix
			rm -f /etc/nixos/result
		'';
	} else throw "build live cd with `nix build path:#livecd` to include .git directory.";
}

