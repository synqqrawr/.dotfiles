import Hyprland from "gi://AstalHyprland";
import { bind, Variable, Gtk } from "astal";

const hyprland = Hyprland.get_default();

const Workspace = ({ id }: { id: number }) => {
  // Extract bindings for workspaces and focused workspace
  const workspaces = bind(hyprland, "workspaces");
  const focused = bind(hyprland, "focusedWorkspace");

  const className = Variable.derive(
    [workspaces, focused],
    (workspaces, focused) => {
      const workspace = workspaces.find((w) => w.id === id);
      if (!workspace) return "Workspace";

      const occupied = workspace.get_clients().length > 0;
      const active = focused.id === id;

      return `Workspace ${active ? "active" : occupied ? "occupied" : ""}`;
    },
  );

  const handleClick = () => {
    hyprland.dispatch("workspace", `${id}`);
  };

  return (
    <box>
      <box hexpand />
      <button className="WorkspaceClick" onClick={handleClick}>
        <box className={className()} valign={Gtk.Align.CENTER} />
      </button>
      <box hexpand />
    </box>
  );
};

export default function Workspaces() {
  const handleScroll = (_, e) => {
    hyprland.dispatch("workspace", e.delta_y > 0 ? "+1" : "-1");
  };

  return (
    <eventbox onScroll={handleScroll}>
      <box className="Workspaces">
        {Array.from({ length: 10 }, (_, i) => (
          <Workspace key={i + 1} id={i + 1} />
        ))}
      </box>
    </eventbox>
  );
}
