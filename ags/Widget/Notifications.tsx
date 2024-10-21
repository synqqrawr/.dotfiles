import { GLib, Variable, bind, timeout } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

const time = (time: number, format = "%H:%M") =>
  GLib.DateTime.new_from_unix_local(time).format(format);

const EXPIRY_TIME = 7000; // Time to wait before removing a notification (5 seconds)

export default function Notification(monitor: number) {
  const anchor = Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;

  const notifd = Notifd.get_default();
  const recentNotifications = Variable([]);

  notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id);

    const currentNotifications = recentNotifications.get();
    recentNotifications.set([...currentNotifications, n]);

    timeout(EXPIRY_TIME, () => {
      const updatedNotifications = recentNotifications
        .get()
        .filter((notification) => notification.id !== n.id);
      recentNotifications.set(updatedNotifications);
    });
  });

  return (
    <window
      className="Notification"
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
    >
      <box vertical>
        {bind(recentNotifications).as((ns) => {
          return ns.map((notification, index) => (
            <eventbox
              key={index}
              onHoverLost={() => {
                // Remove notification without dismissing
                const currentNotifications = recentNotifications.get();
                const updatedNotifications = currentNotifications.filter((n) => n.id !== notification.id);
                recentNotifications.set(updatedNotifications);
              }}
            >
              <box
                transition="slide_left"
                transition_duration={10}
                className="Notifications"
                vertical
              >
                <box>
                  <label
                    truncate="end"
                    maxWidthChars={30}
                    hexpand
                    wrap
                    halign={Gtk.Align.START}
                    className="Summary"
                    label={notification.summary.trim() || "[BLANK]"}
                  />
                  <box halign={Gtk.Align.END}>
                    <label
                      truncate="end"
                      maxWidthChars={30}
                      hexpand
                      wrap
                      className="txt-smallie"
                      label={time(notification.time)}
                    />
                    <button
                      className="closeButton"
                      css={`
                        all: unset;
                        margin-left: 10pt;
                      `}
                      onClicked={() => {
                        notification.dismiss();
                        const currentNotifications = recentNotifications.get();
                        const updatedNotifications = currentNotifications.filter((n) => n.id !== notification.id);
                        recentNotifications.set(updatedNotifications);
                      }}
                    >
                      <icon icon="window-close-symbolic" />
                    </button>
                  </box>
                </box>
                {notification.body && notification.body.trim() !== "" && (
                  <label
                    halign={Gtk.Align.START}
                    maxWidthChars={100}
                    hexpand
                    wrap
                    xalign={0}
                    truncate="end"
                    className="txt-smallie Body"
                    label={notification.body}
                  />
                )}
              </box>
            </eventbox>
          ));
        })}
      </box>
    </window>
  );
}
