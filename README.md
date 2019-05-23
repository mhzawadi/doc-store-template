


# Template Document Git repo

This template can be cloned and used to make a document store repo in Git,
all folders should have a `.template` file. The `.template` file will get used as
the index header.

All files should use markdown, as github will reder them as HTML.
you then have change tracking of all files.

Before pushing to github, please run the mkindex.sh script to rebuild the index pages. `./mkindex.sh`

Please move the post-merge.hook to the ./.git/hooks/ directory, this will auto build indexes whe you pull updates. `mv post-merge.hook .git/hooks/post-merge`

## tools

There are two tools in this repo

- `mkdir` will make a new directory and create a template file
- `mkindex` will rebuild the index files, please run this before you commit!

## code comments

If you include any code in a page, please use the right [language](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml) as it will colour code.

----
