#!/bin/sh

# Handle conflicts: remove rust if rustup is desired, remove nodejs if nodejs-lts is desired
for pkg in rust nodejs; do
    if pacman -Qi "$pkg" >/dev/null 2>&1; then
        echo "Removing conflicting package $pkg..."
        sudo pacman -Rns "$pkg" --noconfirm
    fi
done

yay -S --noconfirm --needed base-devel openssl zlib rustup || return 1

if command -v rustup >/dev/null 2>&1; then
    rustup toolchain install stable
    rustup default stable
fi

cargo install fnm
fnm install 24
fnm use 24
yay -S --noconfirm --needed nodejs-lts-jod bun deno || true

if command -v deno >/dev/null 2>&1; then
    deno completions bash > deno.bash
    if [ -d "/usr/local/etc/bash_completion.d/" ]; then
      sudo mv deno.bash /usr/local/etc/bash_completion.d/
      source /usr/local/etc/bash_completion.d/deno.bash
    elif [ -d "/usr/share/bash-completion/completions/" ]; then
      sudo mv deno.bash /usr/share/bash-completion/completions/
      source /usr/share/bash-completion/completions/deno.bash
    else
      echo "Please move deno.bash to the appropriate bash completions directory"
    fi
fi
