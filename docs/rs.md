documentation wrote in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

fec
---

forward error correction ( fec ) or channel coding is a technique used for __controlling errors__ in data transmission over unreliable or noisy communication channels

goal is simple : just add redundancy bits to the transmitted information with those bits you can easily detect and correct errors with channel coding algorithms


reed-solomon
---

reed-solomon channel coding is part of fec techniques

reed-solomon is a subset of __BCH codes__ and __linear block codes__

it is specified as a function `RS( n, k )`


reed-solomon codes
---

reed-solomon codes are a subset of __BCH codes__

it's characteristics are :

- non-binary block code

- error-correcting code based on univariate polynomials over finite fields

- able to detect and correct multiple symbol errors

- used to mostly correct the __burst errors__

- can correct up to `2 * e + v <= nsym`, where e is the number of errors, v the number of erasures and nsym = n-k = the number of ECC (error correction code) symbols


galois field
---

a finite field or Galois field is a field that contains a finite number of elements

it is specified as a function `GF( p )` where p is a prime number


reed solomon and adsl
---

for adsl modem, code is specified as `RS( 240, 224, t=8 )` that is to say :

- 224 bytes at input
- 240 bytes at output
- and 8 out of 224 bytes can be corrected

it's a block code thats add 16 bytes of redundancy behind 224 bytes of payload ( charge utile )

if more than 8 bytes are detected as erroneous, data block is marked as faulty


matlab
---

RS blocks are available on Simulink Library Browser in `Communications System Toolbox\Error detection and Correction`

2 main components are available : __Binary-Input RS Encoder__ and __Binary-Output RS Decoder__

a [`rsenc`](http://fr.mathworks.com/help/comm/ref/rsenc.htm) function is also available


usefull sources
---

here are some usefull sources I found on the internet :

- https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html

- https://en.wikipedia.org/wiki/Reed–Solomon_error_correction

- http://research.swtch.com/field

- http://cwww.ee.nctu.edu.tw/course/channel_coding/chap5.pdf


