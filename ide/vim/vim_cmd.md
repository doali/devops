# Vim command

## Terminal command line

|command|description|
|-------|-----------|
|vim +line_number <file>|open file at <line_number>|
|vim +/line_number <file>|open file at <line_number>|
|vim +/<function_name> <file>|open file at <function_name> line definition|


## Mode command

|command|description|
|-------|-----------|
|:set list|show invisible characters|
|:set nolist|hide invisible characters|
|`/<pattern>\c`|case insensitive|
|`/<pattern>\C`|case sensitive|
|:echo @% |directory/name of the current file from the working directory|
|<g>;|move through edit positions (forward)|
|<g>,|move through edit positions (backward)|
|<Crtl>o|jump list (forward)|
|<Crtl>i|jump list (backward)|
|ciw'Ctrl+r"'|quote a word using single quote (`"` aka the last yank/delete)|

### Case

|command|description|
|-------|-----------|
|~   | Changes the case of current characte|
|guu | Change current line from upper to lower|
|gUU | Change current LINE from lower to upper|
|guw | Change to end of current WORD from upper to lower|
|guaw| Change all of current WORD to lower|
|gUw | Change to end of current WORD from lower to upper|
|gUaw| Change all of current WORD to upper|
|g~~ | Invert case to entire lin|
|g~w | Invert case to current WOR|
|guG | Change to lowercase until the end of document|

## Biblio
- [riptutorial](https://riptutorial.com/vim/example/26471/invisible-characters)
- [fandom](https://vim.fandom.com/wiki/Get_the_name_of_the_current_file)
- [quote a word](https://superuser.com/questions/782391/vim-enclose-in-quotes)
