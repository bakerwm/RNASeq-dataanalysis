Start Github and using Git SSH
===============================

1. Create a Github account
    * Go to [Github](https://github.com/) and create your account.

2. Download Git bash tool
    * Download **Git bash** for windows on [Git-scm](http://git-scm.com/downloads).
    * Install the *Git-1.9.4-preview20140611.exe* using default settings.

3. Configure the SSH connection with remote github
    * Run the Git bash, and create SSH keys

        ```
    ssh-keygen  -t rsa  -C "wangmcas@gmail.com"
    \\ Create privite and public keys for the Email account
```
    * Record the file **id_rsa.pub** in direcotry **.ssh**

4. Setting the Github website
    * Account Settings -> SSH keys -> Add SSH key
    * Paste the content of **id_rsa.pub** to the window.

5. Setting the local git ssh
    * Run the following command lines
        ```
git config --global user.email  "wangmcas@gmail.com"
git config --global user.name "bakerwm"
```
## How to use Git Bash?
### Options 1: Upload local files to Github web repo

1. Create an empty repo on Github website: [eg: *test-temp*]

2. Initiate the git bash
        ```
	git init
	\\# Move your files to the current directory
	git add  <your files>
	git commit -m 'Initial my project'
	git remote add origin git@github.com:bakerwm/test-temp.git
	git push -u origin master
```

### Options 2: Clone a Web repo to local PC
        ```
    git clone  git@github.com:bakerwm/hello.git
    Create local files
    git add <local files>
    git commit -m 'add new files'
    git push
```

### Options 3: Update my local files
        ```
    \\# Modify/Create the local files
    git add <your files>
    git commit -m 'update files'
    git push origin master
```

### Options 4: git pull
Not known.
