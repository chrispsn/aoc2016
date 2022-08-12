/ k9 li 2021.10.21 1 7
/ may need some |': to exclude bracket-inclusive substrings
/ part 1 could be vectorised more
/ ragged indexing can shine here
/
/ see also:
/ https://github.com/mkst/aoc/blob/master/2016/07.q
/ https://www.reddit.com/r/adventofcode/comments/5gy1f2/2016_day_7_solutions/

s: :':
input: 0:`7.txt

/ PART 1

/ input:("abba[mnop]qrst";"abcd[bddb]xyyx";"aaaa[qwer]tyui";"ioxxoj[asdfgh]zxcvbn")

f:{seqs:+(x;s x;s s x;s s s x)
   isABBA:{(~=/2#x)&x~|x}'seqs
   inbrackets:mod+\x in "[]"
   (|/isABBA) &/ ~isABBA & inbrackets}

105~+/f'input

/ PART 2

/ input:("aba[bab]xyz";"xyx[xyx]xyx";"aaa[kek]eke";"zazbz[bzb]cdb";"aba[zaz]bcb[cbc]oke")

/ cut + raze
/ alt ABAs:{</=/:/(+x)(0;1 2)}#ABAs

f:{x:"[",x
   x:(&x in "[]")^+(s s x;s x;x)
   x@:&'~\:mod!#x
   ABAs:,/x 0
   BABs:,/x 1
   ABAs:{</(*x)=/:1_x:+x}#ABAs
   ABAs:(3#1_)'ABAs
   |/ABAs in BABs}
   
/ shorter
f:{x:"[",x
   x:(&x in "[]")^+(s s x;s x;x)
   x@:&'~\:mod!#x
   x:,/'x
   x:@[x;0;(3#1_)'{</(*x)=/:1_x:+x}#]
   |/in/x}

258~+/f'input

/ alternative that avoids the cut+raze via group.
/ note group sorts by keys in k9. no destructuring assignment.

g:{inbrackets:mod+\x in "[]"
   x:+(s s x;s x;x)
   x:=x!inbrackets
   ABAs:*x
   BABs::/x
   ABAs:{</(*x)=/:1_x:+x}#ABAs
   ABAs:(3#1_)'ABAs
   |/ABAs in BABs}

/ shorter. ~~0 fixes a type issue in 2021.10.21
g:{inbrackets:mod+\x in "[]"
   x:+(s s x;s x;x)
   x:=x!inbrackets
   x:@[x;~~0;(3#1_)'{</(*x)=/:1_x:+x}#]
   |/in/x}

258~+/g'input

\t:10 +/f'input
\t:10 +/g'input

\\
