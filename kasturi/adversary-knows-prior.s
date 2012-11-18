(define B 2) 
(define D 4)
(define N 20)

; Takes the dot product of two vectors A and B
(define dotprod (lambda (A B)
  (sum (map (lambda (x y) (* x y)) A B))))

; Dot products each sample by the same random vector
(define obfuscate (lambda (random samples)
  (map (lambda (S) (dotprod random S)) samples)))
 
; Draws a sample from some distribution
(define draw-sample (lambda ()
  (repeat D (lambda () (sample-integer B)))))

; Draws and memoizes a sample from the uniform (0, 1) distribution
(define draw-random (lambda ()
  (repeat D (lambda () (uniform-draw '(0 1))))))

(define chosen-random (draw-random))
(define observed-samples (repeat N draw-sample))
(define observed-data (obfuscate chosen-random observed-samples))

(define mh-output (mh-query 10 10
  (define random (draw-random))
  (define samples (repeat N draw-sample))
  (define gen-data (obfuscate random samples))
 
  ; what i would like to know
  random
 
 ; what i know
 (equal? gen-data observed-data)
))

(list 'random chosen-random 'samples observed-samples 'guess mh-output)

