{
	pkgs,
	...
}: {
	imports = [
	];

	home.packages = with pkgs; [
		coreutils-full
		zip
		unzip
		p7zip
		blahaj
	];
}

