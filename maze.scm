; ===========================imports used==============================

(import canvas)
(import html)
(import music)

(note 67 qn)

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
(define cheatbtn
  (button "button" "cheat"))



; ========================creating the button's fucntionalities=================================

(define positionx (vector 0)
  )
(define positiony (vector 50))
; =======================Changing colors of the maze and peices==========================

(define color-bank
  (vector "orange" "yellow" "purple" "white"))

(define color-of-square
  (vector "red")
  )

(define color-changer
  (lambda ()
    (vector-set! color-of-square 0 (vector-ref color-bank (random (vector-length color-bank))) )
    )
  )


; =============================================================
(button-onclick upbtn
  (lambda ()
    (begin (vector-set! positiony 0 (- (vector-ref positiony 0 )10 ) ) (color-changer))) )


(button-onclick downbtn
  (lambda ()
    (begin (vector-set! positiony 0 (+ (vector-ref positiony 0 )10 ))
      (color-changer)
      )))

(button-onclick leftbtn
  (lambda ()
    (begin (vector-set! positionx 0 (- (vector-ref positionx 0 ) 10 ))
      (color-changer)
      )))

(button-onclick rightbtn
  (lambda ()
    (begin (vector-set! positionx 0 (+ (vector-ref positionx 0 ) 10 ))
      (color-changer)
      )))

(button-onclick resetbtn
  (lambda ()
    (begin (vector-set! positionx 0 0) (vector-set! positiony 0 50) (color-changer))))

(button-onclick cheatbtn
  (lambda ()
    (begin (vector-set! positionx 0 400) (vector-set! positiony 0 490) (color-changer))))
; -========================creating the canavas================================
(define cvs (canvas 560 560))


(define color-of-rectangle 
  (vector "black")
  )




(define color-of-inside-walls
  "green"
  )
(define color-of-otuside-walls
  "blue"
  )




(animate-with 
  (lambda (time)
    (begin 
      ;--------- background color= ------------
      
      (rectangle cvs 0 0 560 560 "solid" (vector-ref color-of-rectangle 0))
      ;--------- position of the users box (red square) ------------
      
      (rectangle cvs (vector-ref positionx 0) (vector-ref positiony 0) 20 20 "solid" (vector-ref color-of-square 0))
      ;--------- outer wall ------------
      (rectangle cvs 40 70 340 10 "solid" color-of-inside-walls)
      (rectangle cvs 410 70 110 10 "solid" color-of-inside-walls)
      (rectangle cvs 380 110 120 10 "solid" color-of-inside-walls)
      (rectangle cvs 490 120 10 80 "solid" color-of-inside-walls)
      (rectangle cvs 410 200 90 10 "solid" color-of-inside-walls)
      (rectangle cvs 380 240 140 10 "solid" color-of-inside-walls)
      (rectangle cvs 370 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 410 150 10 50 "solid" color-of-inside-walls)
      (rectangle cvs 410 150 50 10 "solid" color-of-inside-walls)
      (rectangle cvs 30 40 10 30 "solid" "red")
      
      ;------------------ right spiral---------------
      (rectangle cvs 70 110 350 10 "solid" color-of-inside-walls)
      (rectangle cvs 70 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 70 280 420 10 "solid" color-of-inside-walls)
      (rectangle cvs 110 140 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 150 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 190 140 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 230 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 270 140 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 310 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 310 240 60 10 "solid" color-of-inside-walls)
      (rectangle cvs 320 110 30 10 "solid" "black")
      ;------------------bottom half-----------------------
      (rectangle cvs 70 320 380 10 "solid" color-of-inside-walls)
      (rectangle cvs 480 280 10 90 "solid" color-of-inside-walls)
      (rectangle cvs 70 360 420 10 "solid" color-of-inside-walls)
      (rectangle cvs 70 320 10 120 "solid" color-of-inside-walls)
      (rectangle cvs 110 400 410 10 "solid" color-of-inside-walls)
      (rectangle cvs 70 440 60 10 "solid" color-of-inside-walls)
      (rectangle cvs 70 480 30 10 "solid" color-of-inside-walls)
      (rectangle cvs 70 480 30 10 "solid" color-of-inside-walls)
      (rectangle cvs 130 440 10 90 "solid" color-of-inside-walls)
      (rectangle cvs 170 440 140 10 "solid" color-of-inside-walls)
      (rectangle cvs 170 480 60 10 "solid" color-of-inside-walls)
      (rectangle cvs 260 440 10 50 "solid" color-of-inside-walls)
      (rectangle cvs 220 480 10 50 "solid" color-of-inside-walls)
      (rectangle cvs 300 440 10 90 "solid" color-of-inside-walls)
      (rectangle cvs 340 410 10 80 "solid" color-of-inside-walls)
      (rectangle cvs 340 480 140 10 "solid" color-of-inside-walls)
      (rectangle cvs 480 410 10 80 "solid" color-of-inside-walls)
      (rectangle cvs 440 410 10 40 "solid" color-of-inside-walls)
      (rectangle cvs 390 410 10 40 "solid" color-of-inside-walls)
      ; -----------------start of maze builiding --------------------------------------
      (rectangle cvs 30 30 500 10 "solid" color-of-otuside-walls) 
      (rectangle cvs 30 70 10 450 "solid" color-of-otuside-walls)
      (rectangle cvs 30 520 500 10 "solid" color-of-otuside-walls)
      (rectangle cvs 520 40 10 480 "solid" color-of-otuside-walls)
      (rectangle cvs 520 410 10 30 "solid" "black")
      (rectangle cvs 400 400 40 10 "solid" "black")
      (rectangle cvs 520 410 10 30 "solid" "red"))
    ))



cvs

upbtn
downbtn
leftbtn
rightbtn
resetbtn
cheatbtn

