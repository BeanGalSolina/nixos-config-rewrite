{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		rosegarden
	];

	services.fluidsynth = {
		enable = true;
		soundFont = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
		soundService = "pipewire-pulse";
	};

	xdg.configFile."wireplumber/wireplumber.conf.d/99-midi-autoconnect.conf".source = ./wp-link.conf;
}

