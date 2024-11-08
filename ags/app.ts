import { App } from "astal/gtk3";
import style from "./styles/index.scss";
import Bar from "./Widget/Bar";
import Applauncher from "./Widget/Applauncher"
import NotificationPopups from "./Widget/notifications/NotificationPopups"

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
  },
});
