(define B 2) 
(define D 100)
(define N 1)

; Takes the dot product of two vectors A and B
(define dotprod (lambda (A B)
  (sum (map (lambda (x y) (* x y)) A B))))

; Dot products each sample by the same random vector
(define obfuscate (lambda (random samples)
  (map (lambda (S) (dotprod random S)) samples)))
 
; Draws a sample from some distribution
(define draw-sample (lambda () (rejection-query
  (define X (repeat D (lambda () (uniform-draw '(0 1)))))
  X
  (equal? (sum X) 2)
)))

; Draws sample from the uniform (0, 1) distribution i.i.d for each element.
(define draw-random (lambda ()
  (repeat D (lambda () (uniform-draw '(0 1))))
))

(define true-samples (repeat N draw-sample))
(define true-random (draw-random))
(define true-obfuscated (obfuscate true-random true-samples))

(define mh-guesses (mh-query 100 10
  (define samples (repeat N draw-sample))
  ;(define random (draw-random))
  (define random true-random)
  (define obfuscated (obfuscate random samples))
 
  ; query
  (equal? (first samples) (first true-samples))

  ; conditions
  (equal? true-obfuscated obfuscated)
))

(list 'true-random true-random 'samples true-samples 'guesses mh-guesses)

