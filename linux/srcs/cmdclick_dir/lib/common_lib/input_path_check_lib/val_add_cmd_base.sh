#!/bin/bash


add_cmd_base="yad --form \
    --title=\"\${WINDOW_TITLE}\" \
    --window-icon=\"\${WINDOW_ICON_PATH}\" \
    --item-separator='!'\
    --center \
    --scroll \
    --height=\${CENTER_SCALE_DISPLAY_HEIGHT} \
    --width=\${CENTER_SCALE_DISPLAY_WIDTH}"