{
	pkgs,
	inputs,
	...
}: {
	home.packages = [ (inputs.fluxer.packages."${pkgs.stdenv.hostPlatform.system}".fluxer.overrideAttrs (oldAttrs: {
		postInstall = (oldAttrs.postInstall or "") + ''
			substituteInPlace $out/share/applications/*.desktop \
				--replace-fail "fluxer-launcher" "fluxer"
		'';
	})) ];
}

