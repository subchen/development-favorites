使用下例中`ssky-keygen`和`ssh-copy-id`，仅需通过3个步骤的简单设置而无需输入密码就能登录远程Linux主机。 

* ssh-keygen 创建公钥和密钥。 
* ssh-copy-id 把本地主机的公钥复制到远程主机的authorized_keys文件上。
* ssh-copy-id 也会给远程主机的用户主目录（home）和~/.ssh, 和~/.ssh/authorized_keys设置合适的权限 。

####步骤1: 用 `ssh-key-gen` 在本地主机上创建公钥和密钥

```bash
$ ssh-keygen -t  rsa
Enter file in which to save the key (/home/sub/.ssh/id_rsa):[Enter key] 
Enter passphrase (empty for no passphrase): [Press enter key]
Enter same passphrase again: [Pess enter key]
Your identification has been saved in /home/sub/.ssh/id_rsa.
Your public key has been saved in /home/sub/.ssh/id_rsa.pub. 
The key fingerprint is: 35:a4:b9:2f:c1:53:2a:42:88:df:89:dc:c1:e3:b8:a2 
```

####步骤2: 用 `ssh-copy-id` 把公钥复制到远程主机上

```bash
$ ssh-copy-id root@10.79.53.164
Could not open a connection to your authentication agent.
root@10.79.53.164's password:
Now try logging into the machine, with "ssh 'root@10.79.53.164'", and check in:

  .ssh/authorized_keys

to make sure we haven't added extra keys that you weren't expecting.

```
> 注: ssh-copy-id 把公钥分发即追加到远程主机的 .ssh/authorized_key 上.

####步骤3: 直接登录远程主机

```bash
$ ssh root@10.79.53.164
Last login: Thu May 21 02:46:19 2015 from 10.140.80.223
root@vbox$ 
```
> 注: 无需输入密码
