# GIT Commands

___

## Basic

### **git init**

Initialise a Git repository in the current working directory. 

### **git status**

Show the status of the current git repository (changes not staged, committed or pushed, current branch).

- **git add \<new-file>**

Begin tracking the given file. 

- **git commit -m "commit message"**

Creates a new commit with the staged changes and the given message. 

- **git merge \<branch-name>** 

Merges the given branch into the currently selected (active) branch. Can also be written explicitly: **git merge \<target-branch> \<source-branch>**. 

- **git log**

**git log** - Verbose list of commits on current branch.

**git log --oneline** - Condenses output to one line for each commit. 

**git log --oneline --all --graph** - Creates an acyclic graph of the entire (--all) commit history.

___

## Comparing

- **git diff** 

Compares the working directory with the index and shows changes.

- **git diff \<branch-name>**

Compares branch with the current working directory (e.g. **git diff \<branch-name> \<working-directory>**).

- **git diff --cached / --staged**

Compares the files in Git's object database with the changes added to the index. 

- **git diff target-branch source-branch**

Compares target-branch to source branch. 

- **git diff --word-diff**

Shows differences on same line (more compact view).

- **git diff \<commit-id-a> \<commit-id-b>**

Compares differences between commits using commit IDs. 

- **git diff HEAD~1 HEAD**

Compare differences between heads. HEAD\~1 (also written as HEAD\~) references the direct parent, HEAD\~2 references the grandparent and so on. In instances of multiple direct parents, HEAD^1 references the first parent and HEAD^2 references the second. This notation can be combined: HEAD^1\~2 references the grandparents of the first parent of HEAD (the current commit).
___

## Branching
- **git branch**

Check which branch is currently active. 

- **git branch -optional \<new-branch>**

Create a new branch with the name \<new-branch>. Options can include the -d flag (delete), -D (force delete), m/M (move/force move [also used to rename]) and c/C (copy/force copy).

- **git switch \<branch-name>**

Switch to the given branch. 

___
## Undoing 

- **git restore \<file-name>**

Discards changes in current working directory (essentially opposite of **git add** command). Takes a copy of a file in the index and overwrites the file in the current directory. Works for multiple files. 

- **git restore --staged \<file-name>**

Unstages the specified file, restoring from the object database. 

- **git rm \<file-name>**

Deletes file from current working directory and removes from index. Use commit to confirm the deletion, or restore to abort it. 

- **git rm -r \<directory>**

Recursively deletes all the files in the directory you specify. Use commit to confirm or restore to abort. 

- **git mv \<file-name-a> \<file-name-b>**

Moves or renames a tracked file. Updates current working directory and index. 

- **git commit -amend -m "amended commit message"** - Changes the message for the last commit on the branch (check that you have a clean working directory with git status first to avoid committing other changes). If you have staged changes use **git restore -staged** to unstage them prior to amending. 

- **git reset \<commit-ID>**

Moves the HEAD *and* the branch to the specified commit. Commit can also be specified using HEAD notation: **git reset HEAD~2**. 

- **git reset --option**

##################add something here 

___

## Collaboration

-- **git clone \<source-url>**

Retrieve copy of repository from URL. Optionally add the name of the folder you want to add it to (otherwise the remote folder name will be used).

- **git push** 

Pushes new commit to remote. Requires GitHub username and personal access token (not the password).

- **git push --set-upstream origin \<local-branch>**

Push a local branch to remote,  creating a remote tracking branch locally. Can also be performed using a shortcut: **git push -u origin \<local-branch>**. 

- **git remote**

Shows the name of the remote repository (fetch and push). Optional flags **--v** (verbose) and **--vv** (very verbose).

- **git branch --vv** 

Will display the remote tracking branches (if any) for each local branch. 

- **git branch --all** 

Shows all branches including remote tracking branches. Can also use shortcut **-a**. Can be combined with **-v** or **-vv**. 

- **git pull** 

#############################

When you invoke **git pull** you should be on the branch which needs to be updated. 

It is the same as **git fetch** followed by **git merge**. 

- **git fetch**

Downloads all new commits and branches from the remote - without affecting your local branches (unlike **git pull**). It only updates the tracking branches, pointing origin/master to the new commit, but leaving your local master where it is. 

Essentially it is just downloading the structure of the current repo so you are aware?

Can prune (delete unused tracking branches) with the **--prune** flag (or **-p**). 

- **git push -d origin \<old-branch>**

Delete upstream branches. 

___

## Searching

- **git blame \<file-name>**

**git blame** shows you each line in the file, with details about the commit that last revised that line (including commit ID, author and time). Can also specify a commit to view the history for: **git blame \<commit-ID> \<file-name>**. Use **--suppress** or **-s** to hide author and timestamp info. 

- **git grep \<search-term>** 

Searches across repository for all instances of the search term. When using a search phrase be sure to include quotes: "search phrase". 

**--ignore-case** or **-i**

**--line-number** or **-n**

**--name-only** or **-l** (list only filenames)

- **git log -S \<search-term>**

Similar to **git blame** but searches entire repository (unless provided with an additional filename argument - **git log -S \<search-term> \<file-name>**). This is referred to as one of the **git log** "pickaxe" options. 

**-p** or **--patch** - e.g. **git log --online --all --graph --patch** displays the commit graph along with the changes made in each commit. 

**git log -p -S \<search-term>** Shows you every commit that has the search term in its diff, as well as the diff itself (in reverse chronological order). 

**git log -p --online -S \<search-term> --word-diff**

**-G** flag - Shows every time a particular string shows up in the diff of a commit (it doesn't need to have changed specifically, just something on the same line). Can be useful in cases such as knowing when the number of arguments to a function were changed by searching the function string. 
Accepts regular expressions and strings as arguments. The second "pickaxe" flag. 

**git log --grep /<search-term>** - Return all commits where the commit message includes the search term. Can combine with **--graph**, **--oneline**, etc. 

**git checkout \<commit-ID>** - "Flips" back to any commit given an ID (reloads save). Puts you in [detached HEAD state](#detached-HEAD-state). 

### **git bisect**

Initiate a bisect session to chase down a bug or chance. Begin with **git bisect start**, then **git bisect bad \<commit-ID>** (if you don't specify, HEAD will be chosen). This indicates that this is the commit that you first noticed the issue. Then input **git bisect good \<commit-ID>**, giving the ID of the last known "good" commit (where the bug was not present).

Git will then perform a binary search of the commit history, stopping to checkout commits for you to examine. Make any terminal queries, examine the files, or run automatic tools. If the commit is good, **git bisect good**, otherwise **git bisect bad**. This process continues until the culprit is found and its information returned at the terminal. 

Once you have finished, use **git bisect reset**. 


### CHAPTER 7 - notes in notebook TODO

### CHAPTER 8

Configuring git

git config --global user.email \<user-email>

Project-specific Git Configuration 

git config --local user.email \<user-email>
(if you don't specify global or local, Git will assume local, but will error out if you are not in a repository)
Local values take precedent - Git reads the global ones, then the local ones, and merges them together giving local overwrite priority. 

By dropping the provided argument, Git will simply return the current value (e.g. ```git config user.name``` will return the currently applicable user name).

```git config --local --unset user.email```

```git config --list```
Lists all the options you've set, global and local. The **--show-origin** flag shows where Git picked up each setting. 

### Git Aliases (shortcuts)

```git config --global alias.loga "log --oneline --graph --all"```

```git help loga``` 

```git config alias-loga```

 -> shows the expanded expression

### .gitignore

### Good Commit Messages

- Always use the imperative mood e.g. "update documentation", "fix intermittent bug when logging in"
- Invoke the ```git commit``` command with no flags. This will bring up your default editor so you can make a longer, more meaningful and commit message with the benefits of formatting. 
- Focus on the *why* of the change, not the *how* or the *what*. 

feat: update CSS style names to be consistent (#6174)
TYPE  COMMIT MESSAGE                          TICKET #

feat: use this when introducing a new feature or enhancement
fix: use this when fixing a bug
docs: use this to describe and documentation change
chore: use this when you make a change that affects tooling, like Git (e.g. modifying the .gitignore file)
test: use this when you introduce or modify tests

---

# Git Terms

## Local Tracking Branches 

## Pull (Github)

Essentially a merge conducted on GitHub. Distinct from the git command **pull**. 

## detached HEAD state

This occurs when you check out a specific commit. A commit made in this state will be lost unless you create a new branch, as it is not associated with a specific branch. Command **git switch -c /<new-branch-name>**.

You can continue to make edits and commits, but switching away from that commit history means you will abandon your commits (since they are not referenced by a branch).

---


# Git Tips

**Keep commits focused on a discrete task**

To aid development and to ensure that commit messages are concise, it is strongly recommended that each commit is contained to a single issue, such as fixing a bug or implementing something distinct. 

**Merging in collaborative projects should be done in Github via pull**

When merging changes into main/master, you should do this via Github instead of merging remotely and pushing the commit to remote. This is so your colleagues have a chance to examine your changes, provide any feedback and catch and issues that may exist. 

**Fetch early and often**

Use **git fetch -p** or **git fetch --prune** to update your remote tracking branches often to ensure you know what's in remote and whether to delete any unnecessary local branches. 