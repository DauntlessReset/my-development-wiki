# GIT Commands



## Basic

### ```git init```

Initialise a Git repository in the current working directory. This is the first command you run when started a Git repo. 

### ```git status```

Show the status of the current git repository (changes not staged, committed or pushed, current branch).

### ```git add <new-file>```

Add file to the index, referred to as a "staging area". A new file in the working directory will be "untracked" before it is added. 

### ```git commit -m "commit message"```

Creates a new commit with the staged changes and the given message. A commit is a snapshot of the changes that were stored in the index. 

Leaving out the **-m** flag will open the editor for you to record your commit message in more detail. 


## Branching

### ```git branch```

Check which branch is currently active. 

- ```git branch -<option> <new-branch>```

Create a new branch with the name \<new-branch>. 

Options can include the -d flag (delete), -D (force delete), m/M (move/force move [also used to rename]) and c/C (copy/force copy). You can also supply the ID of a commit you want to use as the basis for a branch, e.g. ```git branch <branch-name> <commit-ID>```.

- ```git branch --vv``` 

Will display the remote tracking branches (if any) for each local branch. Remote branches marked as "gone" indicates that the local branch no longer has a remote counterpart. 

- ```git branch --all``` 

Shows all branches including remote tracking branches. Can also use shortcut **-a**. Can be combined with **-v** or **-vv**. 

### ```git switch <branch-name>```

Switch to the given branch. 

### ```git merge <branch-name>``` 

Merges the given branch into the currently selected (active) branch. Can also be written explicitly: ```git merge <target-branch> <source-branch>```. 


## Logging

### ```git log```

Shows the commit history of our repository, by default, listing all the commits and corresponding metadata on the current branch.

- ```git log --oneline``` - Condenses output to one line for each commit. 

- ```git log --oneline --all --graph``` - Creates an acyclic graph of the entire (--all) commit history. Alias **loga**. 

-  ```git log --stat``` - Shows which files were modified in each commit, along with the number of lines added or removed. 


## Comparing

### ```git diff``` 

Compares the working directory with the index and shows changes.

- ```git diff <branch-name>```

Compares branch with the current working directory (e.g. ```git diff <branch-name> <working-directory>```).

- ```git diff --cached / --staged```

Compares the files in Git's object database with the changes added to the index. 

- ```git diff target-branch source-branch```

Compares target-branch to source branch ("tip" commits). 

- ```git diff --word-diff```

Shows differences on same line (more compact view).

- ```git diff <commit-id-a> <commit-id-b>```

Compares differences between commits using commit IDs. 

- ```git diff HEAD~1 HEAD```

Compare differences between heads. See [HEAD references](#HEAD-references). 


## Undoing 

### ```git restore```

By default, discards changes in current working directory (essentially opposite of ```git add``` command). Takes a copy of a file in the index and overwrites the file in the current directory. Works for multiple files. 

- ```git restore <file-name>```

Restores a specific file only. 

- ```git restore --staged <file-name>```

Unstages the specified file, replacing the contents of the files in the index with the version last committed from the object database. 

### ```git rm <file-name>```

Deletes file from current working directory and removes from index. Use commit to confirm the deletion, or restore to abort it. 

- ```git rm -r <directory>```

Recursively deletes all the files in the directory you specify. Use commit to confirm or restore to abort. 

### ```git mv <file-name-a> <file-name-b>```

Moves or renames a tracked file. Updates current working directory and index. 

### ```git commit -amend -m "amended commit message"```

Changes the message for the last commit on the branch (check that you have a clean working directory with git status first to avoid committing other changes). If you have staged changes use ```git restore --staged``` to unstage them prior to amending. 

### ```git reset <commit-ID>```

Moves the HEAD *and* the branch to the specified commit. Commit can also be specified using HEAD notation: **git reset HEAD~2**. By default the **--mixed--** variant is used. 

- ```git reset --soft <commit-ID>``` - This option simply takes the edits you committed and moves that back into the index, and then from the index it copies those changes to the working directory. Simply commit again to reinstate the changes.

- ```git reset --mixed <commit-ID>``` - Moves the changes from the commit you undid into to the working directory, and the changes from the commit you are reverting to into the index. 

- ```git reset --hard <commit-ID>``` - Overwrites both the index and the current working directory with the specified commit. It's as if the commit being undone never happened, and the changes are lost forever. Not recommended. 

### ```git revert <commit-id>```

This creates an "anti-commit" - that is, a commit that introduces a set of changes that negate the changes of the commit you wish to undo. 


## Collaboration

### ```git clone <source-url>```

Retrieve copy of repository from URL. Optionally add the name of the folder you want to add it to (otherwise the remote folder name will be used).

### ```git push``` 

Pushes new commit to remote. Requires GitHub username and personal access token (not the password).

- ```git push --set-upstream origin <local-branch>```

Push a local branch to remote,  creating a remote tracking branch locally. Can also be performed using a shortcut: ```git push -u origin <local-branch>```. 

### ```git remote```

Shows the name of the remote repository (fetch and push). Optional flags **--v** (verbose) and **--vv** (very verbose).

### ```git pull``` 

Updates a specific branch (the one you are on or specify). IT fetches all new commits on the remote and updates the local branch's commit history to look like the remote. 

It is the same as ```git fetch``` followed by ```git merge```. 

### ```git fetch```

Downloads all new commits and branches from the remote - without affecting your local branches (unlike **git pull**). It only updates the tracking branches, pointing origin/master to the new commit, but leaving your local master where it is. Essentially downloads the structure of the remote repo so you can see it's state without effecting your local work. 

Can prune (delete unused tracking branches) with the **--prune** flag (or **-p**). 

### ```git push -d origin <old-branch>```

Delete upstream branches. 

___

## Searching

### ```git blame <file-name>```

```git blame``` shows you each line in the file, with details about the commit that last revised that line (including commit ID, author and time). Can also specify a commit to view the history for: ```git blame <commit-ID> <file-name>```. Use **--suppress** or **-s** to hide author and timestamp info. 

### ```git grep <search-term>```

Searches across repository for all instances of the search term. When using a search phrase be sure to include quotes.

**--ignore-case** or **-i**

**--line-number** or **-n**

**--name-only** or **-l** (instead of listing all matches just shows filenames)

### ```git log -S <search-term>```

Similar to ```git blame``` but searches entire repository (unless provided with an additional filename argument - ```git log -S <search-term> <file-name>```) for when a phrase was added or removed . This is referred to as one of the ```git log``` "pickaxe" options. 

**-p** or **--patch** - Displays the patch introduced in each commit e.g. ```git log --online --all --graph --patch``` displays the commit graph along with the changes made in each commit. 

- ```git log -p --online -S <search-term> --word-diff```

Shows you every commit that has the search term in its diff, as well as the diff itself (in reverse chronological order). 

### ```git log -G <search-term>```

Shows every time a particular string shows up in the diff of a commit (it doesn't need to have changed specifically, just something on the same line). Can be useful in cases such as knowing when the number of arguments to a function were changed by searching the function string. 
Accepts regular expressions and strings as arguments. The second "pickaxe" flag. 

- ```git log --grep <search-term>``` - Return all commits where the commit message includes the search term. Can combine with **--graph**, **--oneline**, etc. 

### ```git checkout <commit-ID>``` 

"Flips" back to any commit given an ID (reloads save). Puts you in [detached HEAD state](#detached-HEAD-state). 

### ```git bisect```

Initiate a bisect session to chase down a bug or other issue. Requires the ID of the commit where you first noticed the problem, and the ID of the last known good commit (i.e. one where the bug was not present).

1. ```git bisect start```
2. ```git bisect bad <commit-id>``` (if not specified, HEAD is default)
3. ```git bisect good <commit-id>```

Git will then perform a binary search of the commit history, stopping to checkout commits for you to examine. Make any terminal queries, examine the files, or run automatic tools. If the commit is good, ```git bisect good```, otherwise ```git bisect bad```. This process continues until the culprit is found and its information returned at the terminal. 

Remember, you will be in detached HEAD state as bisect checks out different commits. Once you have finished, use ```git bisect reset```. 


## Configuration

### ```git config```

Allows you to set and override many settings (global and local) e.g. ```git config --global user.email <user-email>```. Global is system-wide, local are repository specific and take precedence. If you don't specify global or local, Git will assume local, but will error out if you are not in a repository.

By dropping the provided argument, Git will simply return the current value (e.g. ```git config user.name``` will return the currently applicable user name).

- ```git config --local --unset user.email``` - Use to revert an override.

- ```git config --list``` - Lists all the options you've set, global and local. The **--show-origin** flag shows where Git picked up each setting. 

### Git Aliases (shortcuts)

```git config --global alias.loga "log --oneline --graph --all"``` - Creates an alias of the given command. After creating the alias, typing ```git loga`` has the same effect as the command sequence. 

```git help <alias-name>``` - Tells you what an alias is a shortcut for. This ```git config alias.loga``` also shows the expanded expression.

### .gitignore
A file at the root of your respository that lists all the files you wish Git to ignore. This file can be commented using *#*. 

### ```git tag <tag-name>```

Records a tag attached to a commit to record an important landmark, e.g. a specific version or release (v1.0.0), the fixing of a particularly egregious bug, or the introduction of an important feature. 

You can specify a commit, otherwise Git will tag the current commit pointed to by HEAD. 

You can pull and push tags using the **--tags** flag.

### ```git cherry-pick <commit-id>``` 

Use to copy a specific commit to another branch. 

This should only be used as a last resort, in situations where you are absolutely not ready to merge the branch where the work was done. 

### ```git stash```

AKA pseudo-commits. Use when you accidentally make changes on the wrong branch.

Several changes can be stored (last in, first out [LIFO]).

To restore a stash: ```git stash pop --index```

Again, these should only really be used if you are stuck in a bad situation such as the one described above. 

You can choose to stash just a single file, or individual changes from within files. If you pass the ```-p``` option (or ```---patch```) to ```git stash```, it will iterate through each changed hunk in your working copy and ask whether you wish to stash it. 

### ```git relog```

Short for reference log. Is updated every time HEAD moves. Is stored FIFO. 

Say you are in detached HEAD state. You switch away to another branch or commit, but now you can't recall which commit you had checked out previously. You can use reflog to retrace your steps and retrieve the commit, even if it no longer has any references. 


### rebase

Another way to merge. Rebase allows you to merge two branches by moving one branch on top of another, effectively merging the two without actually merging. 


Do not rebase public commits, as the commit IDs are changed by this process. 

### Good Commit Messages

- Invoke the ```git commit``` command with no flags. This will bring up your default editor so you can make a longer, more meaningful commit message with the benefits of formatting. 
- Focus on the *why* of the change, not the *how* or the *what*. 

**Header**

- Always use the imperative mood e.g. "update documentation", "fix intermittent bug when logging in"
- All in lowercase except for acronyms and proper nouns 
- Example format:

| feat: | update CSS style names to be consistent | (#6174) |
|:-----:|:---------------------------------------:|:--------|
| TYPE  | COMMIT MESSAGE                          | TICKET #|

**feat**: use this when introducing a new feature or enhancement

**fix**: use this when fixing a bug

**docs**: use this to describe a documentation change

**chore**: use this when you make a change that affects tooling, like Git (e.g. modifying the .gitignore file)

**test**: use this when you introduce or modify tests

**Body**

- Add a blank line separating the header from the body. 
- Each list item is prefixed with a hyphen. 
- Each line item is a sentence with a capital letter, and punctuation if necessary

---

# Git Terms

## Branches

Branches allow you to work on multiple tasks at the same time. In Git you are always working on a branch. In a typical workflow, some branches are treated as "integration" branches to collect the work done in other branches. In contrast, day-to-day work is done in "feature" branches.

## Commits

When you make a commit, Git creates a copy of the files in the index and stores them in the object database. It also creates a commit object that records metadata regarding the commit, including a pointer to the files that were just stored, the author name and email, time the commit was made, and the commit message. 

Each commit is identified by a unique string referred to as the commit ID. 

Except for the initial commit, each commit stored contains the ID of the commit that appeared before it, creating a string of commits referred to as the commit history. 

## HEAD

HEAD is essentially a pointer that keeps track of which commit is currently checked out. Usually, HEAD points to the currently checked out branches latest commit. However, in detached HEAD state, the HEAD does not point to any branch but rather a specific commit.

You can see what HEAD points to with:

```cat .git/HEAD```

### HEAD references

HEAD\~1 (also written as HEAD\~) references the direct parent, HEAD\~2 references the grandparent and so on. In instances of multiple direct parents, HEAD^1 references the first parent and HEAD^2 references the second. This notation can be combined: HEAD^1\~2 references the grandparents of the first parent of HEAD (the current commit).
### detached HEAD state

This occurs when you check out a specific commit. A commit made in this state will be lost unless you create a new branch, as it is not associated with a specific branch. Command ```git switch -c /<new-branch-name>```.

You can continue to make edits and commits, but switching away from that commit history means you will abandon your commits (since they are not referenced by a branch).
## Hunk

Hunks are bite-sized sections of text or code displayed when viewing **diff** output. Each hunk has lines prefixed with a minus or a plus (indicating the changes came from file "a" or "b").

## Git LFS

Git LFS (Large File Storage) is a git extension that reduces the impact of large files in your repository by downloading the relevant versions of them *lazily*. That is, large files are downloaded during the checkout process rather than during cloning or fetching. 

Git LFS does this by replacing large files in your repository with pointers. 

This is because large files stored alongside every commit in a commit history would quickly eat up huge amounts of storage. 

## Local Tracking Branches 

Local tracking branches are a local representation of the state of the remote branches, based on the last time remote was contacted. They are like the local repository's mental image of the state of the remote branches. ```git fetch``` updates your tracking branches. 

## Pull (Github)

Essentially a merge conducted on GitHub. Distinct from the git command **pull**. Requires oversight and approval from the team to finalise the merge. 



---


# Git Tips

**Keep commits focused on a discrete task**

To aid development and to ensure that commit messages are concise, it is strongly recommended that each commit is contained to a single issue, such as fixing a bug or implementing something distinct. Refer to the commit message conventions for further information. 

**Merging in collaborative projects should be done in Github via pull**

When merging changes into main/master, you should do this via Github instead of merging remotely and pushing the commit to remote. This is so your colleagues have a chance to examine your changes, provide any feedback and catch and issues that may exist. 

***Please note that while this is normal practice, due to our small team, we do not follow this convention.***

**Fetch early and often**

Use **git fetch -p** or **git fetch --prune** to update your remote tracking branches often to ensure you know what's in remote and whether to delete any unnecessary local branches. This helps prevent merge hell later on. 