# MAKE SURE TO USE SYSTEM LIBS IN MC
{
	pkgs,
	lib,
	...
}: {
	home.packages = [
		(pkgs.prismlauncher.override {
			additionalLibs = with pkgs; map lib.getLib [
				libdecor
				gtk3
				sdl3
			];
		})
	];
}

