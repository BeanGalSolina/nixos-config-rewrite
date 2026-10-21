{
	config,
	pkgs,
	lib,
	...
}: {
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
		extraPackages = with pkgs; [
			gamescope
		];
		extraCompatPackages = with pkgs; [
			dwproton-bin
			proton-ge-bin
			steam-play-none
		];
	};

	programs.gamescope = {
		enable = true;
		capSysNice = false;
	};

	hardware.steam-hardware.enable = true;

	environment.variables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = lib.makeSearchPathOutput "steamcompattool" "" config.programs.steam.extraCompatPackages;
	environment.systemPackages = [
		pkgs.steam
		pkgs.steamcmd
	];
}

