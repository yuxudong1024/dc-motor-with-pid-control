## Mirror to GitHub repo for GitHub Action to run

(https://github.com/yuxudong1024/dc-motor-with-pid-control/tree/master)

On the GitHub Repo, we need to [enable write permission](https://seekdavidlee.medium.com/how-to-fix-post-repos-check-runs-403-error-on-github-action-workflow-f2c5a9bb67d) to get test result

For some reason, the auto-mirror is stop working, so I roll back to manual mirror:

Setup the upstream mirror:

`system('git remote add upstream https://github.com/yuxudong1024/dc-motor-with-pid-control')`

Then, everytime mirror the upstream:

`system('git push upstream master')`

`system('git push --tags upstream')`