#!/usr/bin/fish

# Using the Connector Names (more reliable for IPC)
set PRIMARY "ViewSonic Corporation XG2703-GS #ASNNX05/aO3d"
set SECONDARY "Dell Inc. DELL U2515H 9X2VY68F06TL"

# 1. Wait 1 second to let the monitors "settle" after Kanshi runs
sleep 5

# 2. Move 'chat' to the secondary monitor
niri msg action focus-workspace chat
niri msg action move-workspace-to-monitor "$SECONDARY"

# 3. Move the work workspaces to the primary monitor
for ws in bum dev term
    niri msg action focus-workspace "$ws"
    niri msg action move-workspace-to-monitor "$PRIMARY"
end
