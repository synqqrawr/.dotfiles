import { GLib, Variable, bind, timeout } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

const time = (time: number, format = "%H:%M") =>
  GLib.DateTime.new_from_unix_local(time).format(format);

const EXPIRY_TIME = 5000; // Time to wait before removing a notification (5 seconds)

export default function Notification(monitor: number) {
  const anchor = Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT;

  const notifd = Notifd.get_default();
  const recentNotifications = Variable([]);

  notifd.connect("notified", (_, id) => {
    const n = notifd.get_notification(id);

    const currentNotifications = recentNotifications.get();
    recentNotifications.set([...currentNotifications, n]);

    timeout(EXPIRY_TIME, () => {
      n.dismiss();
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
                notification.dismiss();
                const currentNotifications = recentNotifications.get();
                const updatedNotifications = currentNotifications.filter(
                  (n) => n.id !== notification.id,
                );
                recentNotifications.set(updatedNotifications);
              }}
            >
              <box className="Notifications" vertical>
                <box>
                  <box>
                    <icon
                      vpack="center"
                      css={`
                        font-size: 50px;
                        min-width: 78px;
                        min-height: 78px;
                      `}
                      icon={"dialog-information-symbolic"}
                    />
                  </box>
                  <box vertical>
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
                            const currentNotifications =
                              recentNotifications.get();
                            const updatedNotifications =
                              currentNotifications.filter(
                                (n) => n.id !== notification.id,
                              );
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
                        valign={Gtk.Align.START}
                        maxWidthChars={100}
                        hexpand
                        vexpand
                        wrap
                        className="txt-smallie Body"
                        label={notification.body}
                      />
                    )}
                    <box vertical={false}>
                      {notification.get_actions() &&
                        notification.get_actions().map((action) => (
                          <button
                            hexpand
                            className="action"
                            onButtonReleaseEvent={() => {
                              notification.invoke(action.id);
                              const currentNotifications =
                                recentNotifications.get();
                              const updatedNotifications =
                                currentNotifications.filter(
                                  (n) => n.id !== notification.id,
                                );
                              recentNotifications.set(updatedNotifications);
                            }}
                          >
                            <label label={action.label} />
                          </button>
                        ))}
                    </box>
                  </box>
                </box>
              </box>
            </eventbox>
          ));
        })}
      </box>
    </window>
  );
}
