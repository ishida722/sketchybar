#!/usr/bin/env sh

# トグル状態を保持するファイル
TOGGLE_STATE_FILE="$HOME/.config/sketchybar/coffee_state"
PID_FILE="$HOME/.config/sketchybar/caffeinate_pid"

# トグル状態を読み込む
if [ -f "$TOGGLE_STATE_FILE" ]; then
    TOGGLE_STATE=$(cat "$TOGGLE_STATE_FILE")
else
    TOGGLE_STATE="off"
fi

# トグル状態を反転してcaffeinateコマンドを実行/停止
if [ "$TOGGLE_STATE" = "off" ]; then
    sketchybar --set $NAME icon="󰅶"
    TOGGLE_STATE="on"
    caffeinate -d &
    CAFFEINATE_PID=$!
    echo "$CAFFEINATE_PID" > "$PID_FILE"
    
else
    sketchybar --set $NAME icon="󰛊"
    TOGGLE_STATE="off"
    if [ -f "$PID_FILE" ]; then
        CAFFEINATE_PID=$(cat "$PID_FILE")
        kill "$CAFFEINATE_PID"
        rm "$PID_FILE"
    fi
fi

# 新しいトグル状態を保存
echo "$TOGGLE_STATE" > "$TOGGLE_STATE_FILE"

