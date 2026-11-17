{
	pkgs,
	pkgsLibreoffice,
	userParams,
	config,
	...
}: let
	packages = with pkgs; [
		smplayer
		pkgsLibreoffice.libreoffice
		gthumb
		yazi
		filezilla
	];

	noinstall = with pkgs; [
		config.programs.librewolf.package
	];
in {
	imports = [ "${userParams.solina.home-modules}/gui/librewolf" ];
	home.packages = packages;
	xdg = {
		enable = true;
		mimeApps = {
			enable = true;
			defaultApplicationPackages = packages ++ noinstall;
		};
	};
}

