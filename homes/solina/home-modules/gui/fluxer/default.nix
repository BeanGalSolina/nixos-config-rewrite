{
	pkgs,
	homeModules,
	inputs,
	...
}: {
	imports = [
		homeModules.altInstances
	];

	homeModules.altInstances."Pinned" = [ (inputs.fluxer.packages."${pkgs.stdenv.hostPlatform.system}".fluxer) ];

	home.packages = let
		updater = pkgs.writeShellApplication {
			name = "fluxer-updater";

			runtimeInputs = with pkgs; [
				zenity
				curl
				coreutils
				gnugrep
				jq
				appimage-run
			];

			text = builtins.readFile ./updater.sh;
		};
	in [
		updater
		(pkgs.makeDesktopItem {
			name = "fluxer";
			desktopName = "Fluxer";
			genericName = "Instant Messenger";
			comment = "Instant messaging and VoIP";
			exec = "${updater}/bin/fluxer-updater %U";
			tryExec = "${updater}/bin/fluxer-updater";
			icon = pkgs.fetchurl {
				url = "https://raw.githubusercontent.com/fluxerapp/fluxer/391d0a2bd47e7bd80add3910f57d6634ccab20e6/fluxer_desktop/build_resources/icons-stable/1024x1024.png";
				hash = "sha256-ExeVp0RkXOaaJDvJyEo2hlE129Pc5jlT7W876Y9JyYg=";
			};
			type = "Application";
			categories = [ "Network" "InstantMessaging" "Chat" ];
			keywords = [ "chat" "im" "messaging" "messenger" "voip" "voice" "video" "call" ];
			startupWMClass = "app.fluxer.Fluxer";
			singleMainWindow = true;
			startupNotify = true;
			mimeTypes = [ "x-scheme-handler/fluxer" ];
			terminal = false;
		})
	];
}

