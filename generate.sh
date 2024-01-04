#!/bin/sh
ruby linkgen.rb < links.yaml | cat index.html.head - index.html.foot > index.html
