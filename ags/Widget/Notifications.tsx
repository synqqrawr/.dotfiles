import { Variable, bind, timeout } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

const EXPIRY_TIME = 5000; // Time to wait before removing a notification (10 seconds)

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
            <box
              transition="slide_left"
              transition_duration={10}
              className="Notifications"
              vertical
              key={index}
            >
              {notification.summary && notification.summary.trim() !== "" && (
                <label
                  truncate="end"
                  maxWidthChars={30}
                  halign={Gtk.Align.START}
                  className="Summary"
                  label={notification.summary}
                />
              )}
              {notification.body && notification.body.trim() !== "" && (
                <label
                  halign={Gtk.Align.START}
                  maxWidthChars={100}
                  wrap={true}
                  xalign={0}
                  truncate="end"
                  className="txt-smallie Body"
                  label={notification.body}
                />
              )}
            </box>
          ));
        })}
      </box>
    </window>
  );
}
