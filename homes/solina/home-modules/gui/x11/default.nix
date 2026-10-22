{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		xorg-server
		xinit
		xrdb
		(pkgs.writeShellScriptBin "x11-nest" ''${builtins.readFile ./x11-nest.sh}'')
	];
}

