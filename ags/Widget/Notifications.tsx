import { Variable, GLib, bind } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

export default function Notification(monitor: number) {
  const anchor = Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;

  const notifd = Notifd.get_default();

  notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id);
    print(n.summary, n.body);
  });

  return (
    <window
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}></box>
        <box>
        </box>
        <box hexpand halign={Gtk.Align.END}></box>
      </centerbox>
    </window>
  );
}
