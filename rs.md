reed solomon
============

reed-solomon codes are a subset of __BCH codes__ and __linear block codes__

reed-solomon is specified as `RS( n, k )`

bch codes
---------

BCH codes ( Bose – Chaudhuri - Hocquenghem ) codes form a large class of multiple random error-correcting codes

- bch codes are cyclic codes ( only codes, not decoding )

reed solomon codes
------------------

reed-solomon codes are a subset of __BCH codes__

characteristics are :

- error-correcting code based on univariate polynomials over finite fields

- able to detect and correct multiple symbol errors

- used to mostly correct the burst errors

- can correct up to `2 * e + v <= nsym`, where e is the number of errors, v the number of erasures and nsym = n-k = the number of ECC (error correction code) symbols


sources
-------

- https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html

- https://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction

- http://research.swtch.com/field

- http://cwww.ee.nctu.edu.tw/course/channel_coding/chap5.pdf
