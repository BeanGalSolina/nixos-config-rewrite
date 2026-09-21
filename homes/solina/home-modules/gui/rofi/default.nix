{
	pkgs,
		config,
		userParams,
		...
}: {
	imports = [
		"${userParams.solina.home-modules}/gui/kitty"
	];

	programs.rofi = {
		enable = true;
		package = pkgs.rofi;

		theme = let
			inherit (config.lib.formats.rasi) mkLiteral;
		in {
			"*" = {
				background-color = mkLiteral "#d67782";
				border-color = mkLiteral "#7b4255";
				foreground-color = mkLiteral "#ffffff";
				width = 512;
			};

			"inputbar" = {
				children = map mkLiteral [ "prompt" "entry" ];
				border = mkLiteral "0 solid 0 2px 0";
			};

			"window" = {
				border = mkLiteral "2px solid";
			};

			"#textbar-prompt-colon" = {
				expand = false;
				str = ":";
				margin = mkLiteral "0 0.3em 0 0";
				text-color = mkLiteral "@foreground-color";
			};

			"element" = {
				spacing = mkLiteral "0";
			};

			"button" = {
				border = mkLiteral "2px solid 0 0 0";
			};

			"button selected" = {
				background-color = mkLiteral "#9d5d7a";
			};
		};

		settings = {
			font = "monospace 12";
			terminal = "${config.programs.kitty.package}/bin/kitty";
			modes = [ "run" "drun" ];

			show-icons = true;
			disable-history = false;
			hide-scrollbar = true;
			sidebar-mode = true;

			drun-display-format = "{icon} {name}";
			display-drun = "   Apps ";
			display-run = "   Run ";
		};
	};
}

