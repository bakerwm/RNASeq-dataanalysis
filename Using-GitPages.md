Get started with Github pages
=========

## 1. Create pages for your project

Goto the **settings** page of your repo, and you can find **Automatic page generator** icon.

It is the easiest way to create a github page.

## 2. Generate Github pages
1. You need a Github account and git bash to push your files to github.
The following sites will help a lot.    
[Site 1](https://help.github.com/articles/set-up-git) & [Site 2](http://www.thinkful.com/learn/a-guide-to-using-github-pages/) 

2. Setting up Github pages
For this demo I will going to build a MingDemo site --nothing complex. My github name is [bakerwm](https://github.com/bakerwm), and the project I will set up is MingDemo, so once I've set up Github Pages, the site can be found here: [http://bakerwm.github.io/MingDemo/](http://bakerwm.github.io/MingDemo/)

The format of the site is: *your-username.github.io/your-project-name*

#### Set up the repository
* Create a repo named "MingDemo" on github web site, and choose option: "initialize this repository with a README"    
* Clone the repo to your local PC   
``` 
    git clone git@github.com:bakerwm/MingDemo.git
```    
* Go to the directory    
```
    cd MingDemo/
```    
* Create a special GitHub Pages branch    
```
    git checkout  --orphan  gh-pages
```    

We'll get a message saying **Switching to a new branch 'gh-pages'
* Make the gh-pages as the default branch

#### Make a Page
* Create a file called *index.html* in *MingDemo* folder    
```
    This is a demo for GitHub Pages.
```    
* Then commit and push our changes    
```
    git add --all .        
    git commit -m 'test page'        
    git push    
```    

#### Done, the first page
You can find the page at: [http://bakerwm.github.io/MingDemo](http://bakerwm.github.io/MingDemo)

## 3. Install Jekyll
The following instructions are based on the following website by @[Julian Thilo](http://jekyll-windows.juthilo.com/)

We need to install Ruby at first, then we need install Jekyll and Syntax. You can find more details @ [http://jekyllrb.com/docs/windows/](http://jekyllrb.com/docs/windows/)

#### Install Ruby
[Get Ruby for windows](http://rubyinstaller.org/downloads/), download (X86/X64) for your system.
Install the Ruby at the **default PATH**, and choose the option: **Add Ruby executables to your PATH**.

#### Install Ruby DevKit
[Get Ruby DevKit](http://rubyinstaller.org/downloads/). Install it at default PATH, like: "C:\RubyDevKit\"

*Open your windows console to finish the following steps.*   

* Go to the RubyDevKit folder
```
    cd  C:\RubyDevKit\
```    
* Auto-detect Ruby installations and add them to configuration file
```
    ruby   dk.rb  init    
```    
* Intall DevKit, binding it to Ruby installation   
```
    ruby  dk.rb  install    
```    
Now, you have Ruby installed on your machine and you can build fully functional executables using Ruby Development Kit. Ruby includes a way to install so-called ***gems-software packages*** from the command line.    

#### Install the Jekyll Gem
Jekyll comes in the form of Ruby Gem, which is an easy-to-install software package. Open your windows console and execute the following commands.    
```
    gem  install  jekyll   
```    
it will take a while to finish the installaion.

#### Highlight your code    
By default, Jekyll comes with pygments.rb, which is a syntax highlighter based on Python. To use it on Windows, you'll need to intall Python and some extra tools.    
A nice alternative is the Ruby-based **Rouge**, which is faster and easier to install, but doesn't support as many languages as Pygments.    

* Install Rouge    
Quick and Pinless: open your console and enter the following command.    
```
    gem  install  rouge    
```    
Then, in your **_config.yml**, set Rouge as your syntax highlighter, add the following line the the file:    
```
    highlighter: rouge    
```    
**Done!**

* Make Pygments work    
If you want to use Pygments for syntax highlighting on Windows, you need to install **Python**, **pip** and finally the Python base of **pygments.rb**.    

    * Install Python    
The latest working version of Python at the time of writing is v2.7.8. Python 3 will not work.    
Download Python v2.7 [Download Python](http://www.python.org/download/)    
Execute the downloaded file and make sure to click on the box next to *Add python.exe to Path* and select "Entire feature will be intalled on local hard drive".    
    * Install pip    
Pip is a tool for installing and managing Python packages, similar to Ruby Gems.

Download **get-pip.py** via the link on that site:    [Download pip](https://pip.pypa.io/en/latest/installing.html)    

Next, open your console and go to the folder where the get-pip.py is. (e.g., c:\pip\)    
```
    cd  C:\pip    
```    
Then, run the following command to automatically download and intall all required components.    
```
    python  get-pip.py       
```    
    * Install Python base of Pygments        
From the command line, run the following command to install the Python base of Pygments.    
```
    pip  install  Pygments    
```    
    * Set Pygments as your syntax highlighter    
Add the following line to your **_config.yml** file, which will set your syntax highlighter.    
```
    highlighter: pygments
```    
* Summary    
Jekyll will now use the highlighter you choose to make all your code blocks look super sleek. We're almost finished.

#### Let Jekyll  --watch
* Install the wdm Gem    
You can instruct Jekyll to have an eye out for changed files to automatically rebuild your site whenever you make changes in the source. On Windows, you need to install one extra tool, or rather Gem, to enable this functionality. Simply run the following command from the command line.    
```
    gem  install  wdm
```    
* Require wdm in your Gemfile
* Alternatively, if you use a Gemfile, you can check if Jekyll runs on Windows and only then install the wdm Gem.    
```
    require 'rbconfig'    
    gem  'wdm', '~> 0.1.0'  if Rbconfig::CONFIG['target_os'] =~ /mswin|mingw/i    
```    
* Summary    
You've now installed everything you need to run Jekyll on Windows. The following minor things can make sure that your sites build smoothy and without problems.

#### Run Jekyll without errors
* No BOM allowed    
If there are **BOM** (Byte order marker) header characters in your UTF-8-encoded files, Jekyll will break. Make sure ther are **NONE**.    

* Set your encoding to UTF-8    
If you followed this guide step by step or if your versions match the ones in this guide, you shouldn't need to use any of the following fixes.

------
* Set **encoding** option
In your **_config.yml** file, add the following line:        
```
    encoding: utf-8    
```    
* Change console encoding    
Alternatively, you can change your command line tool's encoding to UTF-8 by running the following command every time you open a new console window.        
```
    chcp  65001
```    
* The End    
```
    jekyll  build    
    jekyll  build  --watch    
    jekyll  build  -w    
    jekyll  serve    
    jekyll  serve  --watch    
    jekyll  serve  -w    
```    
You can now run all of the above commands on your Windows machine. Congratulations! You have successfully set up Jekyll on Windows.

There are several way to get help if you find the above instruction is not clear.    

* [Look if somebody else noticed it](https://github.com/juthilo/run-jekyll-on-windows/issues?state=open)    
* [File a new issue to Github](https://github.com/juthilo/run-jekyll-on-windows/issues/new)    
* [Visit official Jekyll website](http://jekyllrb.com/)

Jekyll & GitHub Pages    
http://jekyllbootstrap.com/usage/jekyll-quick-start.html#toc_7    
http://developmentseed.org/blog/2011/09/09/jekyll-github-pages/    
http://joshualande.com/jekyll-github-pages-poole/    
http://24ways.org/2013/get-started-with-github-pages/



