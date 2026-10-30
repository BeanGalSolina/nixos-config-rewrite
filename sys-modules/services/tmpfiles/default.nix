{
   pkgs,
   ...
}: {
   systemd.tmpfiles.rules = [
      "d /public 0777 root root - -" # Set public directory
      "A /etc/nixos - - - - user::rwx,user:solina:rwx,group::rwx,mask::rwx,other::r-x" # Set solina and root allowed to write to /etc/nixos
   ];
}

