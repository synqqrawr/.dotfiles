import { App } from "astal/gtk3";
import style from "./styles/index.scss";
import Bar from "./Widget/Bar";

App.start({
  instanceName: "ts",
  css: style,
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main: () => {
    Bar(0);
  },
});
