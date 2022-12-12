# Purpose

Works by pruning your tracking branches then deleting the local ones that
show they are "gone" in `git branch -vv`. <br>
If your language is set to something other than English you will need to
change 'gone' to the appropriate word.

Branches that are local only **will not be touched**. <br>
If `git branch -d` is used, branches that have been deleted on remote but were not
merged will show a notification but not be deleted on local; if you want to delete
those as well, use `git branch -D` (*necessary for deleting branches where the
remote branch was squash-merged or rebased*).

Built starting from [wisbucky's answer](https://stackoverflow.com/a/30494276/5627942)
on [Stackoverflow](https://stackoverflow.com).

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## 1.0.0 - 12/12/2022

### Added

- First version, with a simple ad-hoc script

