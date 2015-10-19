# Install VNC Server

```bash
yum install tigervnc-server
```

# Configure

```bash
mkdir ~/.vnc

cat >> ~/.vnc/xstartup << EOF
#!/bin/sh
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
gnome-session &
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
