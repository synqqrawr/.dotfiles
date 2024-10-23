import { GLib, Variable, bind, timeout } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

const formatTime = (timestamp) =>
  GLib.DateTime.new_from_unix_local(timestamp).format("%H:%M");
const EXPIRY_TIME = 5000; // Time to wait before removing a notification (5 seconds)

export default function Notification(monitor) {
  const anchor = Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;
  const notifd = Notifd.get_default();
  const recentNotifications = Variable([]);

  notifd.connect("notified", (_, id) => {
    const notification = notifd.get_notification(id);
    recentNotifications.set([...recentNotifications.get(), notification]);

    timeout(EXPIRY_TIME, () => {
      const updatedNotifications = recentNotifications
        .get()
        .filter((n) => n.id !== notification.id);
      recentNotifications.set(updatedNotifications);
    });
  });

  const handleDismiss = (notification) => {
    notification.dismiss();
    const updatedNotifications = recentNotifications
      .get()
      .filter((n) => n.id !== notification.id);
    recentNotifications.set(updatedNotifications);
  };

  const handleRemove = (notification) => {
    const updatedNotifications = recentNotifications
      .get()
      .filter((n) => n.id !== notification.id);
    recentNotifications.set(updatedNotifications);
  };

  return (
    <window
      className="Notification"
      monitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
    >
      <box vertical>
        {bind(recentNotifications).as((notifications) =>
          notifications.map((notification, index) => (
            <eventbox
              key={index}
              onHoverLost={() => handleRemove(notification)}
            >
              <box className="Notifications" vertical>
                <box>
                  <icon
                    vpack="center"
                    css={`
                      font-size: 50px;
                      min-width: 78px;
                      min-height: 78px;
                    `}
                    icon="dialog-information-symbolic"
                  />
                  <box vertical>
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
                        label={formatTime(notification.time)}
                      />
                      <button
                        className="closeButton"
                        css={`
                          all: unset;
                          margin-left: 10pt;
                        `}
                        onClicked={() => handleDismiss(notification)}
                      >
                        <icon icon="window-close-symbolic" />
                      </button>
                    </box>
                    {notification.body?.trim() && (
                      <label
                        halign={Gtk.Align.START}
                        valign={Gtk.Align.START}
                        maxWidthChars={100}
                        hexpand
                        vexpand
                        xalign={0}
                        truncate="end"
                        className="txt-smallie Body"
                        label={notification.body}
                      />
                    )}
                  </box>
                </box>
              </box>
            </eventbox>
          )),
        )}
      </box>
    </window>
  );
}
