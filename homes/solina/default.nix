{
	userParams,
	isGui,
	isGaming,
	...
}: {
	home.stateVersion = "25.05";
	imports = [
		"${userParams.solina.home-modules}/imagemagick"
		"${userParams.solina.home-modules}/useless-commands"
		"${userParams.solina.home-modules}/utils"
		"${userParams.solina.home-modules}/fastfetch"
		"${userParams.solina.home-modules}/neovim"
		"${userParams.solina.home-modules}/tmux"
		"${userParams.solina.home-modules}/zsh"
		"${userParams.solina.home-modules}/git"
		"${userParams.solina.home-modules}/jdks"
	] ++ (if isGui || isGaming then [
		"${userParams.solina.home-modules}/gui/fonts"
		"${userParams.solina.home-modules}/gui/mimeapps"
		"${userParams.solina.home-modules}/gui/niri"
		"${userParams.solina.home-modules}/gui/chromium"
		"${userParams.solina.home-modules}/gui/firefox"
		"${userParams.solina.home-modules}/gui/kitty"
		"${userParams.solina.home-modules}/gui/vencord"
		"${userParams.solina.home-modules}/gui/stoat"
		"${userParams.solina.home-modules}/gui/creativity-suite"
	] else []) ++ (if isGaming then [
	] else []);
}

