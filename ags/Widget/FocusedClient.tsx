// https://github.com/end-4/dots-hyprland/blob/c637f5bb8b0eaea704dcd45599dc94713b381a9b/.config/ags/modules/bar/normal/spaceleft.js

import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";
import { Gtk } from "astal/gtk3";

export default function FocusedClient() {
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedClient");

  const renderLabel = (client, labelKey, fallback, maxwidthchars) => {
    return (
      <label
        truncate="end"
        label={client ? bind(client, labelKey).as(String) : fallback}
        maxWidthChars={maxwidthchars}
      />
    );
  };

  return (
    <box valign={Gtk.Align.CENTER}>
      <box vertical className="FocusedClient" css="min-width: 100pt;">
        <box className="txt-smallie">
          {focused.as((client) => renderLabel(client, "class", "Desktop", 40))}
        </box>
        <box className="txt-smaller">
          {focused.as((client) =>
            renderLabel(client, "title", "Workspace", 10),
          )}
        </box>
      </box>
    </box>
  );
}
