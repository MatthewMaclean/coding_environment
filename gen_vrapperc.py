from __future__ import print_function

new = open(".vrapperrc", "w")

SUFFIX = "(ecl)"
LEADER = "'"
group = False
single_line = False

with open(".vimrc") as f:
    for line in f:
        line = line.strip(" \t\n\r")
        to_print = group or single_line
        single_line = False

        if line.startswith("let mapleader=\""):
            LEADER = line[-2]
        elif len(line) == 0:
            group = False
        elif line.endswith(SUFFIX):
            if len(line) > len(SUFFIX) + 2:
                group = True
            else:
                single_line = True
        elif to_print:
            line = line.replace("<Leader>", LEADER)
            line = line.replace("<silent>", "")
            line = line.replace("  ", " ")
            print(line, file=new)

new.close()
