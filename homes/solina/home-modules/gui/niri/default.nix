{
	userParams,
	pkgs,
	lib,
	...
}: let
	confList = lib.filesystem.listFilesRecursive ./conf;
	mkRelative = path: lib.removePrefix "./" (toString (lib.path.removePrefix ./conf path));
in {
	imports = [
		"${userParams.solina.home-modules}/gui/hyprpaper"
		"${userParams.solina.home-modules}/gui/kitty"
		"${userParams.solina.home-modules}/gui/firefox"
		"${userParams.solina.home-modules}/gui/quickshell"
		"${userParams.solina.home-modules}/gui/rofi"
		"${userParams.solina.home-modules}/gui/gtk"
		"${userParams.solina.home-modules}/gui/qt"
		"${userParams.solina.home-modules}/gui/cursors"
		"${userParams.solina.home-modules}/gui/replaybuf"
	];
	
	xdg.portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-termfilechooser
			pkgs.xdg-desktop-portal-gtk
			pkgs.xdg-desktop-portal-gnome
		];

		config.niri = {
			default = [ "termfilechooser" "gtk" "gnome" ];
			"org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
		};
	};
	
	home.file.".bin/niri-active.sh".source = ./niri-active.sh;

	programs.zsh.initContent = lib.mkBefore ''
		if [[ "$(tty)" == "/dev/tty1" ]]
		then
			exec niri-session
		fi
	'';

	home.packages = with pkgs; [
		niri
		dconf
		xwayland-satellite
		jq
		wl-clip-persist
	];

	xdg.enable = true;
	xdg.configFile = builtins.listToAttrs (map (item: {
		name = "niri/${mkRelative item}";
		value = {
			source = lib.mkDefault item;
		};
	}) confList);
}

