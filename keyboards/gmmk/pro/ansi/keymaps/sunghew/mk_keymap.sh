#!/bin/bash -e

ROOT=`git rev-parse --show-toplevel`
DIR="$ROOT/keyboards/gmmk/pro/ansi/keymaps/sunghew"
KEYMAP_FILE="$DIR/gmmk_pro_ansi_mac_layout.json"
C_FILE="$DIR/keymap.c"

# See https://www.reddit.com/r/glorious/comments/okrbjg/peeps_qmk_and_via_rgb_guide_only_for_ansi/
KNOB_FUNC='bool encoder_update_user(uint8_t index, bool clockwise) {
    if (clockwise) {
      tap_code(KC_VOLU);
    } else {
      tap_code(KC_VOLD);
    }
    return true;
}'

# Delete keymap file if it already exists
rm -f $C_FILE

# Create keymap file
(cd $DIR && qmk json2c -o $C_FILE $KEYMAP_FILE) || exit $?

# Add knob function to keymap file
echo "$KNOB_FUNC" >> $C_FILE
