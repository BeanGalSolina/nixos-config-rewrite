{
	pkgs,
	lib,
	...
}: let
	notoLists = import ./noto-generator.nix { inherit pkgs; };
in {
	home.packages = (with pkgs; [
		# Main Fonts
		corefonts
		noto-fonts-color-emoji

		# Fallbacks
		fira-math
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif

		# Extra Fonts
		dancing-script
		vista-fonts
	]) ++ (with pkgs.nerd-fonts; [
		meslo-lg
		symbols-only
	]);

	fonts.fontconfig = {
		enable = true;
		antialiasing = true;

		defaultFonts = let
			unifont = [ "Unifont" "Unifont Upper" ];
			fallback = [ "Symbols Nerd Font" "Fira Math" "Noto Color Emoji" unifont ];
		in {
			sansSerif = lib.lists.flatten [ "Arial" notoLists.sans "Noto Kufi Arabic" fallback ];
			serif = lib.lists.flatten [ "Times New Roman" notoLists.serif "Noto Naskh Arabic" fallback ];
			monospace = lib.lists.flatten [ "MesloLGS Nerd Font" notoLists.mono fallback ];
			emoji = [ "Noto Color Emoji" ];
		};
	};
}

