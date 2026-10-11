{
   pkgs,
   sys-modules,
   ...
}: {
   imports = [
      "${sys-modules}/virtualization"
      "${sys-modules}/programs/r2modman"
      "${sys-modules}/programs/lutris"
      "${sys-modules}/programs/steam"
      "${sys-modules}/bases/gui"
      "${sys-modules}/bases/tty"
   ];

   services.udev.packages = with pkgs; [ game-devices-udev-rules ];

   networking.firewall = {
      allowedTCPPorts = [
         25565
      ];
      allowedUDPPorts = [
         4380
         27036
      ];

      allowedTCPPortRanges = [
         {
            from = 27015;
            to = 27030;
         }
         {
            from = 27036;
            to = 27037;
         }
      ];
      allowedUDPPortRanges = [
         {
            from = 27000;
            to = 27031;
         }
      ];
   };
}

