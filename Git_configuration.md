## Start Github and using Git SSH

1. Create a Github account
    * Go to [Github](https://github.com/) and create your account.

2. Download Git bash tool
    * Download **Git bash** for windows on [Git-scm](http://git-scm.com/downloads).
    * Install the *Git-1.9.4-preview20140611.exe* using default settings.

3. Configure the SSH connection with remote github
    * Start the Git Bash and create SSH keys
```
	    ssh-keygen  -t rsa  -C  "wangmcas@gmail.com"
```

	Create privite and public keys for the Email account

	* Record the file **id_rsa.pub** in direcotry **.ssh**

4. Setting the Github website
    * Account Settings -> SSH keys -> Add SSH key
    * Paste the content of **id_rsa.pub** to the window.

5. Setting the local git
    * Run the following command lines
```
	git config --global user.email "wangmcas@gmail.com"
	git config --global user.name  "bakerwm"
```
6. Test your SSH connection to github
```
        ssh -T git@github.com
```

## How to use Git Bash?
### Options 1: Upload local files to Github web repo

* Create an empty repo on Github website: [eg: *test-temp*]

* Initiate the git bash
```
    git init
    \\ Move your files to the current directory
    git add  <your files>
	git commit -m 'Initial my project'
	git remote add origin git@github.com:bakerwm/test-temp.git
	git push -u origin master
```

### Options 2: Clone a Web repo to local PC
* Record the name of web repo: [eg: *hello*]
* Clone the web repo to local PC and update your files
```
    git clone  git@github.com:bakerwm/hello.git
    Create local files
    git add <local files>
    git commit -m 'add new files'
    git push
```

### Options 3: Update my local files
* cd to your directory
* update your files to web repo 
```
    git add <your files>
    git commit -m 'update files'
    git push origin master
```

### Options 4: git pull
Just try the following command:
    git pull

## Create simple Gitpages

1. Create a repo in your github website: "3Kings4Food"
2. Clone the repo to your local PC
3. Create a special Github Pages branch
```
    git checkout --orphan  gh-pages
```

It will create a new branch, and saying **Switched to a new branch 'gh-pages'**
```
    git checkout gh-pages
```

It will check whether you are in the branch "gh-pages"

4. push your files to the new branch for the first time
```
    git add files
    git commit -m 'update my files'
    git push  --set-upstream origin gh-pages
```

5. You can view your page at: http://bakerwm.github.io/3Kings4Food
Use **HTTP** to access the website, **NOT** *HPPTS*.

