import { Variable, GLib, bind, timeout } from "astal";
import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";
import Notifd from "gi://AstalNotifd";
import Notification from "./notifications/Notification";
import MediaPlayers from "./MediaPlayer";

function hide() {
  App.get_window("ControlCenter")!.hide();
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
      <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      />
    </box>
  );
}

export default function ControlCenter() {
  const { START, CENTER, END } = Gtk.Align;
  const anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT;
  const notifd = Notifd.get_default();
  const HasNotifs = bind(notifd, "notifications").as((ns) => {
    return !(ns.length === 0);
  });
  return (
    <window
      className="ControlCenter"
      name="ControlCenter"
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
      visible={false}
      application={App}
    >
      <box>
        <box expand className="main" vertical>
          <AudioSlider />
          <Gtk.Separator visible margin={15} />
          <box vertical>
            <box>
              <label halign={START} label={"Notifications"} hexpand />
              {/* thx https://git.nelim.org/matt1432/nixos-configs/src/commit/a33fc66b15f9b1ca43b61298f5b15e656810d9db/nixosModules/ags/config/widgets/notifs/center.tsx */}
              <box halign={END} hexpand>
                <eventbox
                  cursor={bind(HasNotifs).as((hasNotifs) =>
                    hasNotifs ? "pointer" : "not-allowed",
                  )}
                >
                  <button
                    className="clear"
                    sensitive={bind(HasNotifs)}
                    onButtonReleaseEvent={() => {
                      notifd.get_notifications().forEach((notif) => {
                        notif.dismiss();
                      });
                    }}
                  >
                    <box>
                      <label label="Clear " />

                      <icon
                        icon={bind(notifd, "notifications").as((notifs) =>
                          notifs.length > 0
                            ? "user-trash-full-symbolic"
                            : "user-trash-symbolic",
                        )}
                      />
                    </box>
                  </button>
                </eventbox>
              </box>
            </box>
            <scrollable vexpand className="notifs">
              <box className="list" spacing={10} vertical>
                {bind(notifd, "notifications").as((ns) =>
                  ns.length === 0 ? (
                    <box vertical css="padding: 1rem;" vexpand hexpand>
                      <label
                        className="placeholder"
                        css="margin-top: 10pt;"
                        label="There's nothing to show; You're all caught up. :)"
                      />
                      <icon
                        css="font-size: 10rem; margin-top: 30pt;"
                        icon={"notifications-disabled-symbolic"}
                      />
                    </box>
                  ) : (
                    ns.slice(0, 100).map((n) =>
                      Notification(
                        {
                          notification: n!,
                        },
                        true,
                      ),
                    )
                  ),
                )}
              </box>
            </scrollable>
            {MediaPlayers()}
          </box>
        </box>
      </box>
    </window>
  );
}
