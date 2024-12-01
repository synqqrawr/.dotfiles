import { App, Gtk } from "astal/gtk3";
import style from "./styles/index.scss";
import Bar from "./Widget/Bar";
import Applauncher from "./Widget/Applauncher";
import NotificationPopups from "./Widget/notifications/NotificationPopups";
import NotificaionCenter from "./Widget/notifications/Center"
import {
  CornerTopleft,
  CornerTopright,
  CornerBottomleft,
  CornerBottomright,
} from "./Widget/ScreenCorners";

const settings = Gtk.Settings.get_default()!;
settings.gtk_enable_animations = true;

App.start({
  css: style,
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main: () => {
    Bar(0);
    NotificationPopups(0);
    Applauncher();
    CornerTopleft(0);
    CornerTopright(0);
    CornerBottomleft(0);
    CornerBottomright(0);
    // NotificaionCenter(0);
  },
});
