import Hyprland from "gi://AstalHyprland";
import { bind, Gtk } from "astal";

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
    <box vertical valign={Gtk.Align.CENTER}>
      <box className="txt-smallie FocusedClient">
        {focused.as((client) => renderLabel(client, "class", "Desktop", 40))}
      </box>
      <box className="txt-smaller">
        {focused.as((client) => renderLabel(client, "title", "Workspace", 20))}
      </box>
    </box>
  );
}
