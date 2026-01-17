# INSTALLATION SCRIPTS KNOWLEDGE BASE

## OVERVIEW
System provisioning logic modularized into individual shell scripts. Orchestrated by `../install-all.sh`.

## MECHANISM: SOURCING
**CRITICAL**: Scripts here are **SOURCED** (`source script.sh`), not executed as child processes.
- **Shared Scope**: Variables defined here persist to subsequent scripts.
- **No `exit`**: `exit` kills the `install-all.sh` process. Use `return` or conditionals.
- **No `set -e`**: Avoid `set -e` as it will cause the parent installer to exit on failure.

## STRUCTURE
- `00-install-stow.sh`: **Destructive Setup**. Clears `~` to prevent Stow symlink conflicts.
- `install-overrides.sh`: Specific Hyprland configuration checks.
- `install-*.sh`: Package groups (e.g., `devel`, `webapps`, `ghostty`).

## CONVENTIONS
- **Ordering**: Prefix with `00-` for early bootstrap. Otherwise, scripts run alphabetically.
- **Safety**: Use `pacman -S --needed` or `yay --needed` for idempotency.
- **Verification**: Use `command -v <cmd>` or `[ -d <path> ]` to guard installation logic.

## ANTI-PATTERNS
- **Exit/Set -e**: Critical failures in sourcing mechanism.
- **Shebang reliance**: Shebangs are ignored; ensure compatibility with the caller (sh/bash).
- **Silent Failures**: Log errors clearly but allow the installer to continue if appropriate.
