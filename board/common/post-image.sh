#!/bin/sh
# shellcheck disable=SC1090
. "$BR2_CONFIG" 2>/dev/null

rm -f "$BINARIES_DIR/start-qemu.sh"
cp -a "$BR2_EXTERNAL_FINIT_DEMO_PATH/board/common/qemu.sh" "$BINARIES_DIR/"
