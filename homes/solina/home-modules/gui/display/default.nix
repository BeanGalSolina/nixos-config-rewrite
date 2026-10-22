{
	userParams,
	pkgs,
	lib,
	...
}: let
	pkg = pkgs.callPackage ./package.nix { };
in {
	imports = [
		"${userParams.solina.home-modules}/gui/niri"
		"${userParams.solina.home-modules}/gui/xfce"
	];

	home.packages = [ pkg ];
	
	programs.zsh.initContent = lib.mkBefore ''
		if [[ "$(tty)" == "/dev/tty1" ]]
		then
			${pkg}/bin/start-desktop
		fi
	'';
}

