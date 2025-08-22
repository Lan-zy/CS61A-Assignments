(define (ascending? s) 
    (if (null? (cdr s))
        #t
        (and (< (car s) (car (cdr s))) (ascending? (cdr s)))
    )
)

(define (my-filter pred s) 'YOUR-CODE-HERE)

(define (interleave lst1 lst2) 'YOUR-CODE-HERE)

(define (no-repeats s) 
    (if (null? s)
      '()
      (if (member (car s) (cdr s))
          (no-repeats (cdr s))
          (cons (car s) (no-repeats (cdr s)))))
)
