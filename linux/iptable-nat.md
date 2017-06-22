# iptables

1. kernel modules

    ```bash
    modprobe ip_tables
    modprobe iptable_nat
    modprobe iptable_filter
    modprobe ip_conntrack
    modprobe ip_conntrack_ftp
    modprobe ip_nat_ftp
    ```

2. ip_forward

    ```bash
    sysctl -w net.ipv4.ip_forward=1
    ```

3. iptables.service

    ```bash
    yum install -y iptables

    systemctl restart iptables.service

    # show rules
    iptables -t nat -L

    # clear rules
    iptables -t nat -F
    
    # save rules
    iptables-save > /etc/sysconfig/iptables
    ```

## Hosts Information

- Jumpbox/Gatewaybox:

    Name     | Interface | IP Address    | Netmask
    -------- | --------- | ------------- | -------------
    Public   | eth0      | 10.123.10.99  | 255.255.255.0
    Internal | eth1      | 192.168.1.99  | 255.255.255.0

    路由表: `route -n`

    ```bash
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    0.0.0.0         10.123.10.1     0.0.0.0         UG    0      0        0 eth0
    10.123.10.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
    192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth1
    ```

- Internal Boxes: `192.168.1.0/24`

## 外网访问内网 (NAT 端口映射)

- User Case:

  ```
  用户通过 10.123.10.99:11022 访问内网机器 192.168.1.11:22

  $ ssh root@10.123.10.99 -p 11022
  ```

- Flow Figure:

  ```
          |
          V
   src: x.x.x.x:xx
  dest: 10.123.10.99:11022
          |
          V
  ---- eth0 (in) --------
          |
          | PREROUTING
          |  (DNAT)
          V
   src: x.x.x.x:xx
  dest: 192.168.1.11:22
          |
          | routing
          V
  ---- eth1 (out) -------
          |
          | POSTROUTING
          |  (SNAT)
          V
   src: 192.168.1.99:xx
  dest: 192.168.1.11:22
          |
          V
  ---- Internal BOX ----
  ```

- Configure:

  - DNAT (任意方法均可)
    - iptables -t nat -A PREROUTING  -p tcp -i eth0 -d 10.123.10.99 --dport 11022 -j DNAT --to 192.168.1.11:22
    - iptables -t nat -A PREROUTING  -p tcp -i eth0 --dport 11022 -j DNAT --to 192.168.1.11:22
    - iptables -t nat -A PREROUTING  -p tcp -d 10.123.10.99 --dport 11022 -j DNAT --to 192.168.1.11:22
    - iptables -t nat -A PREROUTING  -p tcp --dport 11022 -j DNAT --to 192.168.1.11:22

  - SNAT (任意方法均可)
    - iptables -t nat -A POSTROUTING -p tcp -o eth1 -d 192.168.1.11 -j SNAT --to 192.168.1.99
    - iptables -t nat -A POSTROUTING -p tcp -o eth1 -d 192.168.1.0/24 -j SNAT --to 192.168.1.99
    - iptables -t nat -A POSTROUTING -p tcp -d 192.168.1.0/24 -j SNAT --to 192.168.1.99
    - iptables -t nat -A POSTROUTING -p tcp -d 192.168.1.0/24 -j MASQUERADE
    - iptables -t nat -A POSTROUTING -p tcp -o eth1 -j SNAT --to 192.168.1.99
    - iptables -t nat -A POSTROUTING -p tcp -o eth1 -j MASQUERADE

  - 最简单的配置
    ```
    iptables -t nat -A PREROUTING  -p tcp --dport 11022 -j DNAT --to 192.168.1.11:22
    iptables -t nat -A POSTROUTING -p tcp -o eth1 -j MASQUERADE
    ```

  > 注意：
  > 1. 其中 `-j MASQUERADE` 等价于 `-j SNAT --to 192.168.1.99`
  > 2. `-j MASQUERADE` 会自动从服务器的网卡上，获取当前ip地址来做NAT
  > 3. 参考：http://www.cnblogs.com/Dicky-Zhang/p/5934657.html


## 内网访问外网 (直连，GATEWAY)

- User Case:

  ```
  内网机器 192.168.1.0/24 通过网关 10.123.10.99 直接访问外网
  ```

- Flow Figure:

  ```
  ---- Internal BOX ----
          |
          V
   src: 192.68.1.0/24:xx
  dest: x.x.x.x:xx
          |
          V
  ---- eth1 (in) --------
          |
          | routing
          V
  ---- eth0 (out) -------
          |
          | POSTROUTING
          |  (SNAT)
          V
   src: 10.123.10.99:xx
  dest: x.x.x.x:xx
          |
          V
  ```

- Configure:

  1. 在 GatewayBox 上配置

    ```
    iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
    ```

  2. 在内网机器上设置默认 gateway 为 192.168.1.99

    ```
    $ cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
    NAME=eth0
    DEVICE=eth0
    ONBOOT=yes
    BOOTPROTO=static
    IPADDR=192.168.1.11
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.99
    EOF

    $ systemctl restart network.service

    $ route -n
    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
    0.0.0.0         192.168.1.99    0.0.0.0         UG    0      0        0 eth0
    192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
    ```

