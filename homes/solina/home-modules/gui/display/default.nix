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
	];

	home.packages = [ pkg ];
	
	programs.zsh.initContent = lib.mkBefore ''
		if [[ "$(tty)" == "/dev/tty1" ]]
		then
			exec ${pkg}/bin/start-desktop
		fi
	'';
}

