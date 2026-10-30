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
			fallback = [ "Symbols Nerd Font" "Fira Math" "Noto Color Emoji" ];
		in {
			sansSerif = lib.lists.flatten [ "Arial" fallback notoLists.sans "Noto Kufi Arabic" unifont ];
			serif = lib.lists.flatten [ "Times New Roman" fallback notoLists.serif "Noto Naskh Arabic" unifont ];
			monospace = lib.lists.flatten [ "MesloLGS Nerd Font" fallback notoLists.mono unifont ];
			emoji = [ "Noto Color Emoji" ];
		};
	};
}

