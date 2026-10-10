#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

usage() {
    echo "Usage: $0 {setup|attach|clean}"
    echo "  setup   build the image, start the container, run setup.sh"
    echo "  attach  attach current terminal/tmux window to the running container"
    echo "  clean   stop and remove the container"
    exit 1
}

[ $# -eq 1 ] || usage

case "$1" in
    setup)
        xhost +local:docker
        docker compose build
        docker compose up -d
        docker compose exec workspace bash src/.devcontainer/setup.sh
        docker compose exec workspace bash src/.devcontainer/build.sh
        echo "Container is up. Run '$0 attach' in any terminal/tmux window to get a shell."
        ;;
    attach)
        exec docker compose exec workspace bash
        ;;
    clean)
        docker compose down
        ;;
    *)
        usage
        ;;
esac
