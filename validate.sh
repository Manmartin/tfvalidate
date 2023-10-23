#!/bin/bash
errors="$(terraform validate 2>&1 >/dev/null | egrep '\s+on\s.+\sline\s[0-9]+:')"
highlight="hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white"
IFS=$'\n'
for error in $errors; do
  file="$(echo $error | awk '{print $4}')"
  line_number="$(echo $error | awk '{print $6}' | sed 's/.$//')"
  nvim "+$line_number" -c $highlight $file; 
done
