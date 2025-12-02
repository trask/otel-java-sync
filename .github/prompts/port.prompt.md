# Porting PR to Other Repos

When porting a PR to the other repos in this workspace,
fetch upstream and check out a new branch based off upstream/main.

When done porting the PR, commit the changes using the same commit message
as the original PR (with title and body). At the end of the commit message,
add a line that says "Ported from <original PR URL>".

And then push the new branch to origin (using git push -u)
but do not open a PR against upstream/main.

At the end of the porting process, list the URLs for me to go to and open PRs.
