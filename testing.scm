(import canvas)
(import html)
(define cvs (canvas 300 300))

(define btn 
(button "button" "click me")
)

(define color-of-rectangle 
(vector "red")
)

(button-onclick btn
(lambda ()
(vector-set! color-of-rectangle 0 "green")
))

(animate-with 
(lambda (time)
(begin 
(rectangle cvs 0 0 300 300 "solid" (vector-ref color-of-rectangle 0))
(text cvs (number->string time) 50 50 "solid" "blue" "24px sans-serif"))
))


cvs
btn



