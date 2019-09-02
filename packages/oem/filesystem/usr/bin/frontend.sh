#!/bin/sh

@DEFAULT@

. /storage/.config/frontend.conf 2>/dev/null || true

if [ -n "$FRONTEND" ]; then
  systemctl start "$FRONTEND" &
else
  systemctl start "$DEFAULT" &
fi
