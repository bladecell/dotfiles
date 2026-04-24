#!/usr/bin/fish

# 1. Wait for monitors to initialize
sleep 2

# 2. Dynamically set the Connector Names (DP-X)
set PRIMARY (niri msg --json outputs | jq -r '.[] | select(.model == "MAG 274CQF") | .name')
set SECONDARY (niri msg --json outputs | jq -r '.[] | select(.model == "Unknown") | .name')

# 3. Safety Check: Only proceed if both monitors are detected
if test -n "$PRIMARY"; and test -n "$SECONDARY"

    # Move 'chat' to the secondary monitor
    niri msg action focus-workspace chat
    niri msg action move-workspace-to-monitor "$SECONDARY"

    # Move the work workspaces to the primary monitor
    for ws in bum dev term win
        niri msg action focus-workspace "$ws"
        niri msg action move-workspace-to-monitor "$PRIMARY"
    end

    # 4. Final Focus: Ensure we land on workspace 1 on the Primary monitor
    niri msg action focus-workspace 1
    niri msg action move-workspace-to-monitor "$PRIMARY"

else
    echo "Monitor detection failed. Primary: '$PRIMARY', Secondary: '$SECONDARY'"
end
