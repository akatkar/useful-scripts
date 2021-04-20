# Python-scripts

## git-switch
In windows, switching git accounts may be problematic. For example, I had 3 git accounts and I had to switch one from another according to project. But this is not easy like switching in Ubuntu. So I have written this simple script to accelerate switching. 

 - To be able to use, you should create your ssh keys for each git account and save them with specified prefix. 
 - Then you should add this information into accounts json
 - You can list all accounts 
 - You can see current account
 - You can switch to desired account 
```sh
> git-switch --list
> git-switch --current
> git-switch --switch <account>
```

Note that this script just replaces the saved keys as default keys for ssh agent. 

