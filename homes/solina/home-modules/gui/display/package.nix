{
	stdenv,
	ncurses,
	...
}: stdenv.mkDerivation {
	pname = "start-desktop";
	version = "1.0.0";

	buildInputs = [ ncurses ];
	src = ./.;

	buildPhase = ''
		runHook preBuild
		gcc -Wall -Wextra -O2 -std=c23 start-desktop.c -lncurses -o start-desktop
		runHook postBuild
	'';

	installPhase = ''
		runHook preInstall
		mkdir -p $out/bin
		cp start-desktop $out/bin/
		runHook postInstall
	'';
}

