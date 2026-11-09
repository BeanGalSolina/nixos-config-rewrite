{
	...
}: {
	fileSystems = {
		"/home/solina/Sync/figura/data/tmp" = {
			options = [
				"size=1M"
				"mode=777"
				"noexec"
				"nosuid"
				"nofail"
				"noauto"
				"x-systemd.automount"
			];
			depends = [ "/home/solina/Sync/figura/data/tmp" ];
			fsType = "tmpfs";
			device = "tmpfs";
		};

		"/home/solina/Sync/figura/data/avatars" = rec {
			device = "/home/solina/Sync/figura/avatars";
			options = [ "bind" "ro" "nofail" "noauto" "x-systemd.automount" ];
			depends = [ device "/home/solina/Sync/figura/data/avatars" ];
			fsType = "auto";
		};

		"/home/solina/Sync/figura/data/localonly" = rec {
			device = "/home/solina/Sync/figura/avatars/others/simon/host_only";
			options = [ "bind" "ro" "nofail" "noauto" "x-systemd.automount" ];
			depends = [ device "/home/solina/Sync/figura/data" ];
			fsType = "auto";
		};
	};
}

