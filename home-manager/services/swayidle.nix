{
  pkgs,
  config,
  inputs,
  ...
}: {
  services.swayidle = 
  let
    system = pkgs.system;
    lock = "${inputs.noctalia.packages.${system}.default}/bin/noctalia-shell ipc call lockScreen lock";
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in
    {
    enable = true;
    systemdTarget = "niri-session.target";
    timeouts = [
      {
        timeout = 295;
        command = lock; 
      }
      {
        timeout = 600;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
      {
        timeout = 2000;
        command = "${pkgs.systemd}/bin/systemctl hibernate";
      }
    ];
  };
}
