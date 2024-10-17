import { Variable, GLib, bind } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";

import Workspaces from "./Workspaces";
import FocusedClient from "./FocusedClient";

function SysTray() {
  const tray = Tray.get_default();

  return (
    <box className="SysTray">
      {bind(tray, "items").as((items) =>
        items.map((item) => {
          if (item.iconThemePath) App.add_icons(item.iconThemePath);

          const menu = item.create_menu();

          return (
            <button
              tooltipMarkup={bind(item, "tooltipMarkup")}
              onDestroy={() => menu?.destroy()}
              onClickRelease={(self) => {
                menu?.popup_at_widget(
                  self,
                  Gdk.Gravity.SOUTH,
                  Gdk.Gravity.NORTH,
                  null,
                );
              }}
            >
              <icon gIcon={bind(item, "gicon")} />
            </button>
          );
        }),
      )}
    </box>
  );
}

function Wifi() {
  const { wifi } = Network.get_default();

  return (
    <icon
      tooltipText={bind(wifi, "ssid").as(String)}
      className="Wifi"
      icon={bind(wifi, "iconName")}
    />
  );
}

function AudioSlider() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <eventbox
      onScroll={(_, e) => {
        if (!speaker) return;

        speaker.volume = Math.max(
          0,
          Math.min(
            speaker.volume +
              (e.delta_y < 0
                ? speaker.volume <= 0.09
                  ? 0.01
                  : 0.03
                : speaker.volume <= 0.09
                  ? -0.01
                  : -0.03),
            150,
          ),
        );
      }}
    >
      <box className="AudioSlider" css="margin: 0 10px;">
        <icon icon={bind(speaker, "volumeIcon")} />
      </box>
    </eventbox>
  );
}

function BatteryLevel() {
  const bat = Battery.get_default();

  return (
    <box
      className="Battery"
      visible={bind(bat, "isPresent")}
      valign={Gtk.Align.CENTER}
    >
      <icon icon={bind(bat, "batteryIconName")} valign={Gtk.Align.CENTER} />
      <label
        className="txt-smaller"
        valign={Gtk.Align.CENTER}
        label={bind(bat, "percentage").as((p) => `${Math.floor(p * 100)}%`)}
      />
    </box>
  );
}

function Time({ format = "%H:%M - %A %e." }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <label className="Time" onDestroy={() => time.drop()} label={time()} />
  );
}

export default function Bar(monitor: number) {
  const anchor =
    Astal.WindowAnchor.BOTTOM |
    Astal.WindowAnchor.LEFT |
    Astal.WindowAnchor.RIGHT;

  return (
    <window
      className="Bar"
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <FocusedClient />
          <Workspaces />
        </box>
        <box>
          <Time />
        </box>
        <box hexpand halign={Gtk.Align.END}>
          <SysTray />
          <Wifi />
          <AudioSlider />
          <BatteryLevel />
        </box>
      </centerbox>
    </window>
  );
}
