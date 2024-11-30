load-zoxide() {
  eval "$(zoxide init zsh)"
}

z() {
  unset -f z
  load-zoxide
  z "$@"
}

zoxide() {
  unset -f zoxide
  load-zoxide
  zoxide "$@"
}
