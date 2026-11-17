{
	config,
	pkgs,
	lib,
	...
}: {
	imports = [
		./profiles/default
	];

	programs.librewolf = {
		enable = true;
		package = pkgs.librewolf.override {
			extraPrefs = ''
				${builtins.readFile ./goodgirl.js}
			'';
			extraAutoConfig = ''
				pref("general.config.sandbox_enabled", false);
			'';
		};
		configPath = "${config.xdg.configHome}/lenovo";
	};
}

