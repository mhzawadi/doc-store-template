# Template Document Git repo

This template can be cloned and used to make a document store repo in Git, below are the commands to make that work.

```
git clone https://github.com/mhzawadi/doc-store-template.git
mkdir 'doc-store';cd doc-store
git init --template=../doc-store-template
```

all folders should have a `.template` file. The `.template` file will get used as
the index header.

All files should use markdown, as github will reder them as HTML.
you then have change tracking of all files.

Before pushing to github, please run the mkindex.sh script to rebuild the index pages. `./mkindex.sh`

Please move the post-merge.hook to the ./.git/hooks/ directory, this will auto build indexes whe you pull updates. `mv post-merge.hook .git/hooks/post-merge`

----
