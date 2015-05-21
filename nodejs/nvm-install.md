To install you could use the install script using cURL:
```bash
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
```

Or using wget
```bash
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
```

The script clones the nvm repository to `~/.nvm` and adds the source line to your profile 
(`~/.bash_profile`, `~/.bashrc`, `~/.zshrc` or `~/.profile`).

You can customize the install source, directory and profile using the NVM_SOURCE, NVM_DIR, and PROFILE variables. 
Eg: `curl ... | NVM_DIR=/usr/local/nvm bash` for a global install.


NB. The installer can use `git`, `curl`, or `wget` to download `nvm`, whatever is available.

After relogin,  then:
```bash
nvm install stable
```

To set a default Node version to be used in any new shell, use the alias 'default':
```bash
nvm alias default stable
```
