// ty bro: https://raw.githubusercontent.com/hashankur/ags/28a6741d9820ba852355aafe315c14538845a7d1/widget/AppLauncher.tsx

import { App, Astal, Gdk, Gtk, Widget } from "astal/gtk3";
import { bind, Variable } from "astal";
import AstalApps from "gi://AstalApps";

const WINDOW_NAME = "app-launcher";

const apps = new AstalApps.Apps({
  nameMultiplier: 2,
  entryMultiplier: 0,
  executableMultiplier: 2,
});

const query = Variable<string>("");

export default function AppLauncher() {
  const items = query((query) =>
    apps.fuzzy_query(query).map((app: AstalApps.Application) => (
      <button
        on_Clicked={() => {
          App.toggle_window(WINDOW_NAME);
          app.launch();
        }}
        app={app}
      >
        <box hexpand={false}>
          <icon className="AppIcon" icon={app.iconName || ""} />
          <box className="AppText" vertical valign={Gtk.Align.CENTER}>
            <label
              className="AppName"
              label={app.name}
              halign={Gtk.Align.START}
              truncate
            />
            {app.description && (
              <label
                className="AppDescription"
                label={app.description}
                halign={Gtk.Align.START}
                truncate
              />
            )}
          </box>
        </box>
      </button>
    )),
  );

  const Entry = new Widget.Entry({
    text: bind(query),
    hexpand: true,
    canFocus: true,
    placeholderText: "Search",
    className: "AppLauncher-Input",
    primaryIconName: "edit-find",
    onActivate: () => {
      items.get()[0]?.app.launch();
      query.set("");
      App.toggle_window(WINDOW_NAME);
    },
    setup: (self) => {
      self.hook(self, "notify::text", () => {
        query.set(self.get_text());
      });
    },
  });

  return (
    <window
      name={WINDOW_NAME}
      application={App}
      visible={false}
      className="AppLauncher"
      keymode={Astal.Keymode.EXCLUSIVE}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.OVERLAY}
      vexpand={true}
      onKeyPressEvent={(self, event) => {
        let key = event.get_keyval()[1];
        if (key === Gdk.KEY_Escape) {
          if (self.visible) {
            query.set("");
            Entry.grab_focus();
            self.visible = false;
          }
        }
      }}
    >
      <box className="AppLauncher-Base" vertical>
        {Entry}
        <scrollable vexpand>
          <box className="AppLauncher-ItemName" vertical spacing={10}>
            {items}
          </box>
        </scrollable>
      </box>
    </window>
  );
}
