{
	pkgs,
	...
}: {
	environment.systemPackages = let
		script = pkgs.writeShellApplication {
			name = "lutris";
			runtimeInputs = [ pkgs.findutils ];
			text = ''
				declare JOYSTICK
				JOYSTICK="$(find /dev/input/by-id -regex '^.*[^(event)]-joystick$' -printf '%p' -quit)"

				cd "$HOME"

				if [[ -n "$JOYSTICK" ]]
				then
					echo "Using joystick $JOYSTICK"
					SDL_JOYSTICK_DEVICE="$JOYSTICK" exec "${pkgs.lutris}/bin/lutris" "$@"
				else
					exec "${pkgs.lutris}/bin/lutris" "$@"
				fi
			'';
		};
		pkg = pkgs.symlinkJoin {
			name = "lutris";
			paths = [
				script
				pkgs.lutris
			];
		};
	in [ pkg ];
}

