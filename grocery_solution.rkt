#lang scheme
;2016400024

(define (TRANSPORTATION-COST farm)(
                                   TR-CR farm FARMS
                                    ))

(define (TR-CR farm farmList)(
                               if(null? farmList) 0 (
                                                     if (equal? farm (caar farmList))
                                                        (cadar farmList)
                                                        (TR-CR farm (cdr farmList)))))
(define (AVAILABLE-CROPS farm)(
                               A-CR farm FARMS
                               ))
(define (A-CR farm farmList)(
                               if(null? farmList) (list) (
                                                     if (equal? farm (caar farmList))
                                                        (caddar farmList)
                                                        (A-CR farm (cdr farmList)))))
(define (INTERESTED-CROPS customer)(
                                   I-CR customer CUSTOMERS
                                        ))
(define (I-CR customer CList)(
                              if(null? CList) (list) (
                                                     if (equal? customer (caar CList))
                                                        (caddar CList)
                                                        (I-CR customer (cdr CList)))))
(define (CONTRACT-FARMS customer)(
                                   C-FR customer CUSTOMERS
                                        ))
(define (C-FR customer CList)(
                              if(null? CList) (list) (
                                                     if (equal? customer (caar CList))
                                                        (cadar CList)
                                                        (C-FR customer (cdr CList)))))
(define (CONTRACT-WITH-FARM farm)(
                                   C-W-FR farm CUSTOMERS (list)
                                        ))
(define (C-W-FR farm CList contractList)(
                              if(null? CList) contractList (
                                                     if (member farm (cadar CList))
                                                        (C-W-FR farm (cdr CList) (append contractList (list(caar CList))))
                                                        (C-W-FR farm (cdr CList) contractList))))

(define (INTERESTED-IN-CROP crop)(
                                   I-I-CR crop CUSTOMERS (list)
                                        ))
(define (I-I-CR crop CList contractList)(
                              if(null? CList) contractList (
                                                     if (member crop (caddar CList))
                                                        (I-I-CR crop (cdr CList) (append contractList (list(caar CList))))
                                                        (I-I-CR crop (cdr CList) contractList))))
(define (MIN-SALE-PRICE crop)(
                             M-S-PR crop CROPS +inf.0
                                    ))
(define (M-S-PR crop CROPS min)(
                                cond ((and (equal? min +inf.0) (null? CROPS)) 0)
                                     ((and (not(equal? min +inf.0)) (null? CROPS)) min)
                                     ((and (> min (caddar CROPS) ) (equal? crop (caar CROPS)))(M-S-PR crop (cdr CROPS) (caddar CROPS)))
                                     (else (M-S-PR crop (cdr CROPS) min))))
(define (CROPS-BETWEEN min max)(
                             C-BR CROPS min max (list)
                                    ))
(define (C-BR CROPS min max liste)(
                                cond ((null? CROPS) liste)
                                     ((and (<= min (caddar CROPS) )(>= max (caddar CROPS)) (not(member (caar CROPS) liste)))(C-BR (cdr CROPS) min max (append liste (list(caar CROPS)))))
                                     (else (C-BR (cdr CROPS) min max liste))))
(define (BUY-PRICE customer crop)(
                                  
                                  B-PR crop CROPS (CONTRACT-FARMS customer) +inf.0
                                  ))
(define (B-PR crop CROPS fList min)(
                                cond ((and (equal? min +inf.0) (null? CROPS)) 0)
                                     ((and (not(equal? min +inf.0)) (null? CROPS)) min)
                                     ((and (equal? crop (caar CROPS))(> min (+(caddar CROPS) (TRANSPORTATION-COST (cadar CROPS))) ) (member (cadar CROPS) fList))(B-PR crop (cdr CROPS) fList (+(caddar CROPS) (TRANSPORTATION-COST (cadar CROPS)))))
                                     (else (B-PR crop (cdr CROPS) fList min))))

(define (TOTAL-PRICE customer)(
                               TOPLAA customer (INTERESTED-CROPS customer) 0
                               ))
(define (TOPLAA customer CList sum)(
                                    cond((null? CList) sum)
                                        (else (TOPLAA customer (cdr CList) (+ sum (BUY-PRICE customer (car CList)))))
                                    ))










                              
