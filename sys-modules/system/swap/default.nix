{
	...
}: {
	zramSwap.enable = true;
	zramSwap.memoryPercent = 25;

	swapDevices = [
		{
			device = "/var/lib/swapfile";
			size = 32 * 1024;
			priority = 0;
		}
	];
}

