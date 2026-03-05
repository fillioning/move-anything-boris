#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$REPO_ROOT"

if [ ! -d "dist/granular" ]; then
    echo "Error: dist/granular not found. Run ./scripts/build.sh first."
    exit 1
fi

ssh root@move.local "mkdir -p /data/UserData/move-anything/modules/audio_fx/granular"
scp -r dist/granular/* root@move.local:/data/UserData/move-anything/modules/audio_fx/granular/
ssh root@move.local "chmod -R a+rw /data/UserData/move-anything/modules/audio_fx/granular"

echo "Installed to Move. Restart MoveOriginal to load the module."
