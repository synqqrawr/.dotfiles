// https://github.com/N3RDIUM/dotfiles/blob/41dead62a1275b3e11f9035ac1439b8af8d2e107/ags/widget/Workspaces.tsx#L2
//
import Hyprland from "gi://AstalHyprland";
import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";

const hyprland = Hyprland.get_default();

// Thanx to https://github.com/rice-cracker-dev/nixos-config/blob/main/modules/extends/candy/home/desktop/shell/ags/config/widgets/HyprlandWidget/index.tsx
const Workspace = ({ id }: { id: number }) => {
  const className = Variable.derive(
    [bind(hyprland, "workspaces"), bind(hyprland, "focusedWorkspace")],
    (workspaces, focused) => {
      const workspace = workspaces.find((w) => w.id === id);

      if (!workspace) {
        return "Workspace";
      }

      const occupied = workspace.get_clients().length > 0;
      const active = focused.id === id;

      return `Workspace ${active ? "active" : occupied ? "occupied" : ""}`;
    },
  );

  return (
    <button
      className="WorkspaceClick"
      onClick={() => hyprland.dispatch("workspace", `${id}`)}
    >
      <label
        className={className()}
        valign={Gtk.Align.CENTER}
        label={`${id}`}
      />
    </button>
  );
};

export default function Workspaces() {
  return (
    <box>
      {[...Array(15).keys()].map((i) => (
        <Workspace id={i + 1} />
      ))}
    </box>
  );
}
