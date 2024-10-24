import { App } from "astal/gtk3";
import style from "./styles/index.scss";
import Bar from "./Widget/Bar";
import Notifications from "./Widget/Notifications";
import Applauncher from "./Widget/Applauncher"

App.start({
  css: style,
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main: () => {
    Bar(0);
    Notifications(0);
    Applauncher();
  },
});
