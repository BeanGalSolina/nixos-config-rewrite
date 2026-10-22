{
	userParams,
	pkgs,
	...
}: {
	imports = [
		"${userParams.solina.home-modules}/gui/x11"
	];

	home.packages = with pkgs; [
		xfce4-session
		xfce4-panel
		xfdesktop
		xfconf
		xfce4-settings
		xfwm4
		xfce4-exo
	];
}

