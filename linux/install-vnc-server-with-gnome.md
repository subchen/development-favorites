# Install VNC Server

```bash
yum install tigervnc-server
```

# Configure

```bash
mkdir ~/.vnc

cat > ~/.vnc/xstartup << EOF
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec /etc/X11/xinit/xinitrc
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
gnome-session &
# startkde &
EOF

chmod +x ~/.vnc/xstartup
```

# Set Password

```bash
vncpasswd
```

# Start Session

```bash
vncserver
```

# Stop Session

```bash
vncserver -kill :1
```

