#node parse.js -t hello.jade -d data2.json $* | tidy -im 2>/dev/null
if [ -z "$1" ]; then
  node parse.js -t hello.jade -d data2.json $* | less
else
  node parse.js -t hello.jade -d data2.json $* | tidy -im 2>/dev/null
fi
