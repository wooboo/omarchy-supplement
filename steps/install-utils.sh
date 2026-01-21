#!/bin/sh

print_step "CLI Utilities" "Installs common CLI tools: zoxide, fzf, multitail, tree, trash-cli, bash-completion, fastfetch, fd"

yay -S --noconfirm --needed \
    zoxide \
    fzf \
    multitail \
    tree \
    trash-cli \
    bash-completion \
    fastfetch \
    fd
