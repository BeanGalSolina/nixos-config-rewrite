{
	stdenv,
	jdk21,
	fetchurl,
	makeWrapper,
	makeDesktopItem,
	copyDesktopItems,
	...
}: let
	pname = "viaproxy";
	version = "3.4.12";
	jre = jdk21;
in stdenv.mkDerivation {
	inherit pname version;

	dontUnpack = true;
	src = fetchurl {
		url = "https://github.com/ViaVersion/ViaProxy/releases/download/v${version}/ViaProxy-${version}.jar";
		hash = "sha256-Ms6a2HGusDKGgjwp2iYuvXWZKGTnhX2yg/EDUlx/wMs=";
	};

	nativeBuildInputs = [
		makeWrapper
		copyDesktopItems
	];

	buildInputs = [
		jre
	];

	desktopItems = [
		(makeDesktopItem {
			name = "viaproxy";
			exec = "viaproxy";
			comment = "ViaProxy GUI - Version/Protocol Proxy";
			desktopName = "ViaProxy";
			categories = [ "Network" "Game" ];
		})
	];

	installPhase = ''
		mkdir -p "$out/share/java" "$out/bin"
		cp "$src" "$out/share/java/ViaVersion.jar"
		makeWrapper "${jre}/bin/java" "$out/bin/viaproxy" \
			--set-default _JAVA_AWT_WM_NONREPARENTING 1 \
			--run "mkdir -p \''${XDG_DATA_HOME:-\$HOME/.local/share}/viaproxy && cd \''${XDG_DATA_HOME:-\$HOME/.local/share}/viaproxy" \
			--add-flags "-jar $out/share/java/ViaVersion.jar"
		runHook postInstall
	'';
}

