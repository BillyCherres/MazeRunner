; ===========================imports used==============================
(import canvas)
(import html)



; ========================creating the buttons=================================
(define upbtn
(button "button" "up arrow")
)
(define downbtn 
(button "button" "down arrow")
)
(define leftbtn 
(button "button" "left arrow")
)
(define rightbtn 
(button "button" "right arrow")
)
(define resetbtn
(button "button" "reset button"))
; ========================creating the button's fucntionalities=================================

(define positionx  (vector 265)
)
(define positiony (vector 480))
(button-onclick upbtn
(lambda ()
(vector-set! positiony 0 (- (vector-ref positiony 0 )20 ))

))

(button-onclick downbtn
(lambda ()
(vector-set! positiony 0 (+ (vector-ref positiony 0 )20 ))

))

(button-onclick leftbtn
(lambda ()
(vector-set! positionx 0 (- (vector-ref positionx 0 ) 20 ))

))

(button-onclick rightbtn
(lambda ()
(vector-set! positionx 0 (+ (vector-ref positionx 0 ) 20 ))

))

(button-onclick resetbtn
(lambda ()
(begin (vector-set! positionx 0 250) (vector-set! positiony 0 480))))


; -========================creating the canavas================================
(define cvs (canvas 560 500))


(define backround-color 
(vector "black")
)

(animate-with 
(lambda (time)
(begin 
(rectangle cvs 0 0 560 500 "solid" (vector-ref backround-color 0))
(rectangle cvs (vector-ref positionx 0) (vector-ref positiony 0) 20 20 "solid" "red")
)
))



cvs
upbtn
downbtn
leftbtn
rightbtn
resetbtn
