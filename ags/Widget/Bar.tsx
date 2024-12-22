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
    <box className="SysTray" spacing={5}>
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <menubutton
            tooltipMarkup={bind(item, "tooltipMarkup")}
            usePopover={false}
            actionGroup={bind(item, "action-group").as((ag) => [
              "dbusmenu",
              ag,
            ])}
            menuModel={bind(item, "menu-model")}
          >
            <icon gicon={bind(item, "gicon")} />
          </menubutton>
        )),
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
    <box className="AudioSlider">
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

function Time({ format = "%H:%M - %a, %b %e" }) {
  const clock = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return <label onDestroy={() => clock.drop()} label={clock()} />;
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
          <FocusedClient />
          <Gtk.Separator visible margin={10} />
          <Workspaces />
        </box>
        <box>
          <Time />
        </box>
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
              <box spacing={5}>
                <Wifi />
                <AudioSlider />
              </box>
              <Gtk.Separator visible margin={10} />
              <BatteryLevel />
            </box>
          </button>
        </box>
      </centerbox>
    </window>
  );
}
