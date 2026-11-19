{
	userParams,
	pkgs,
	...
}: {
	imports = [
		"${userParams.solina.home-modules}/C"
	];

	home.packages = with pkgs; [
		cargo
		rust-script
	];
}

