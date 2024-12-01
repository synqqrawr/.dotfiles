load-zoxide() {
 eval "$(zoxide init zsh)"
}

z() {
  unset -f z
  load-zoxide
  z "$@"
}

zi() {
  unset -f zi
  load-zoxide
  zi "$@"
}


zoxide() {
  unset -f zoxide
  load-zoxide
  zoxide "$@"
}
