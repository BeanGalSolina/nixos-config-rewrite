{
	pkgs,
	config,
	osConfig,
	...
}: let
	systemClosure = pkgs.closureInfo { rootPaths = osConfig.environment.systemPackages; };
	homeClosure   = pkgs.closureInfo { rootPaths = config.home.packages; };
	totalClosure  = pkgs.closureInfo { rootPaths = osConfig.environment.systemPackages ++ config.home.packages; };

	totalCount = toString
		<| builtins.length
		<| builtins.split "\n"
		<| builtins.readFile "${totalClosure}/store-paths";
	sysCount = toString
		<| builtins.length
		<| builtins.split "\n"
		<| builtins.readFile "${systemClosure}/store-paths";
	homeCount = toString
		<| builtins.length
		<| builtins.split "\n"
		<| builtins.readFile "${homeClosure}/store-paths";
in {
	home.packages = [
		pkgs.fastfetch
	];

	home.shellAliases.fastfetch = "fastfetch --logo ${./logo.txt}";
	home.file.".config/fastfetch/config.jsonc".text = builtins.replaceStrings
		[ "$PKGS$" "$PKGS.SYSTEM$" "$PKGS.HOME$" ]
		[ totalCount sysCount homeCount ]
		(builtins.readFile ./config.jsonc);
}

