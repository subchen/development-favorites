If you did a minimal install, this guide will quicly tell you how to install Gnome GUI on a CentOS 7 or RHEL 7 using a command line options.

## List available software groups

The syntax is as follows to list available software groups on a CentOS/RHEL 7:

```bash
yum grouplist
```

Sample outputs:

```
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirrors.usc.edu
 * extras: mirror.lug.udel.edu
 * updates: mirror.cogentco.com
Available environment groups:
   Minimal Install
   Compute Node
   Infrastructure Server
   File and Print Server
   Basic Web Server
   Virtualization Host
   Server with GUI
   GNOME Desktop
   KDE Plasma Workspaces
   Development and Creative Workstation
Available Groups:
   Compatibility Libraries
   Console Internet Tools
   Development Tools
   Graphical Administration Tools
   Legacy UNIX Compatibility
   Scientific Support
   Security Tools
   Smart Card Support
   System Administration Tools
   System Management
Done
```

## Install Gnome Desktop

To install GNOME desktop group, enter:

```bash
yum groups install "GNOME Desktop"
```

## How do I set the system to boot directly into the GUI in CentOS7/RHEL 7?

```bash
systemctl set-default graphical.target
```

## How do I switch or start GUI login from command line?

```bash
systemctl start graphical.target
```
