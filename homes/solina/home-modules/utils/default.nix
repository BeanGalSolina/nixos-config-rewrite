{
	pkgs,
	...
}: {
	imports = [
	];

	home.packages = with pkgs; [
		coreutils-full
		zip
		p7zip
		blahaj
	];
}

