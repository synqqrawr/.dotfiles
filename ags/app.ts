import { App } from "astal/gtk3";
import style from "./style.scss";
import Bar from "./Widget/Bar";

App.start({
  instanceName: "js",
  css: style,
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main: () => {
    Bar(0);
  },
});
