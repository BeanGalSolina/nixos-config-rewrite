{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		tinycc
		curl
		gcc
		man
		man-pages
	];
}

