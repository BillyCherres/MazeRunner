(import canvas)
(import html)
; -========================creating the canavas================================
(define cvs (canvas 500 500))

(define color-of-rectangle 
(vector "white")
)

; creating the white canvas
(animate-with 
(lambda (time)
(begin 
(rectangle cvs 0 0 500 500 "solid" (vector-ref color-of-rectangle 0))
)
))



cvs