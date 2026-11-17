{
	...
}: {
	services.avahi = {
		enable = true;
		openFirewall = true;
		nssmdns4 = true;

		settings = {
			server = {
				use-ipv4 = true;
				use-ipv6 = true;
			};

			publish = {
				disable-publishing = true;
				publish-addresses = true;
				publish-workstation = true;
			};
		};
	};
}

