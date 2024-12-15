import { Variable, GLib, bind, timeout } from "astal";
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
    <box className="AudioSlider" css="margin: 0 10px;">
      <button
        onClickRelease={() => {
          speaker.volume = speaker.volume && 100 ? 0 : 100;
        }}
      >
        <icon icon={bind(speaker, "volumeIcon")} />
      </button>
    </box>
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

function Time({ format = "%H:%M", date_format = "%a, %b %e" }) {
  const date = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(date_format)!,
  );
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <box
      valign={Gtk.Align.CENTER}
      css="min-width: 30pt; padding: 0 10pt;"
      className="Clock"
    >
      <label label={" "} css="margin-right: 5pt;" />
      <box vertical>
        <box className="txt-smaller">
          <label onDestroy={() => time.drop()} label={time()} />
        </box>
        <box className="txt-smallie">
          <label onDestroy={() => date.drop()} label={date()} />
        </box>
      </box>
    </box>
  );
}

export default function Bar(monitor: number) {
  const anchor =
    Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT;

  return (
    <window
      className="Bar"
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
      layer={Astal.Layer.TOP}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <Time />
          <Gtk.Separator visible margin={10} />
          <FocusedClient />
          <Gtk.Separator visible margin={10} />
          <Workspaces />
        </box>
        <box></box>
        <box hexpand halign={Gtk.Align.END}>
          <SysTray />
          <button
            onButtonReleaseEvent={() => {
              const win = App.get_window("ControlCenter");
              win.set_visible(!win.visible);
            }}
          >
            <box>
              <Gtk.Separator visible margin={10} />
              <Wifi />
              <AudioSlider />
              <BatteryLevel />
            </box>
          </button>
        </box>
      </centerbox>
    </window>
  );
}
