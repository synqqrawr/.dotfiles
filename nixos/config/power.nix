{ lib, ... }:
{
  powerManagement = {
    powertop = {
      enable = lib.mkForce true;
    };
  };
  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        DISK_DEVICES = "sda"; # DISK_DEVICES must be specified for AHCI_RUNTIME_PM settings to work right.
        AHCI_RUNTIME_PM_ON_AC = "on"; # with AHCI_RUNTIME_PM_ON_AC/BAT set to defaults in battery mode, P51
        AHCI_RUNTIME_PM_ON_BAT = "on"; # can't resume from sleep and P50 can't go to sleep.
        # AHCI_RUNTIME_PM_ON_BAT = "auto";

        # with RUNTIME_PM_ON_BAT/AC set to defaults, P50/P51 can't go to sleep
        # RUNTIME_PM_ON_AC = "on";
        # RUNTIME_PM_ON_BAT = "on";
        # RUNTIME_PM_ON_BAT = "auto";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_ENERGY_PERF_POLICY_ON_AC = "ondemand";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "ondemand";

        CPU_MAX_PERF_ON_AC = 99;
        CPU_MAX_PERF_ON_BAT = 75;
        CPU_MIN_PERF_ON_BAT = 75;

        CPU_SCALING_GOVERNOR_ON_AC = "performance"; # Adjust as needed
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave"; # Adjust as needed

        NATACPI_ENABLE = 1;

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "on"; # or auto

        SCHED_POWERSAVE_ON_BAT = 1;

        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 1;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;

        TPACPI_ENABLE = 1;
        TPSMAPI_ENABLE = 1;

        WOL_DISABLE = "Y";
      };
    };
  };
}
