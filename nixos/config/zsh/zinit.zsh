autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

zinit ice as'completion' blockf
zinit light zsh-users/zsh-completions

# Load completions
autoload -U compinit && compinit

# FZF when tabbing for completions
# WARN: Must be after compinit to work
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# -q is for quiet; actually run all the `compdef's saved before `compinit` call
# (`compinit' declares the `compdef' function, so it cannot be used until
# `compinit' is ran; Zinit solves this via intercepting the `compdef'-calls and
# storing them for later use with `zinit cdreplay')
zinit cdreplay -q
