

(import canvas)
(import html)
; -========================creating the canavas================================
(define cvs (canvas 560 560))

(define color-of-rectangle 
  (vector "white")
  )


(rectangle cvs 0 0 560 560 "solid" "white")
; creating the white canvas
(animate-with 
  (lambda (time)
    (begin 
      (rectangle cvs 0 0 500 500 "solid" (vector-ref color-of-rectangle 0))
; -----------------start of maze builiding --------------------------------------
      (rectangle cvs 30 30 500 10 "solid" "black") 
      (rectangle cvs 30 70 10 450 "solid" "red")
      (rectangle cvs 30 520 500 10 "solid" "blue")
      (rectangle cvs 520 40 10 480 "solid" "yellow")
      ;--------- outer wall ------------
      (rectangle cvs 30 70 350 10 "solid" "blue")
      (rectangle cvs 410 70 110 10 "solid" "blue")
      (rectangle cvs 380 110 120 10 "solid" "green")
      (rectangle cvs 490 120 10 80 "solid" "yellow")
      (rectangle cvs 410 200 90 10 "solid" "green")
      (rectangle cvs 380 240 140 10 "solid" "green")
      (rectangle cvs 370 110 10 140 "solid" "green")
      (rectangle cvs 410 150 10 50 "solid" "yellow")
      (rectangle cvs 410 150 50 10 "solid" "green")
      ;------------------ right spiral---------------
      (rectangle cvs 70 110 350 10 "solid" "blue")
      (rectangle cvs 70 110 10 140 "solid" "black")
      (rectangle cvs 70 280 420 10 "solid" "black")
      (rectangle cvs 110 140 10 140 "solid" "black")
      (rectangle cvs 150 110 10 140 "solid" "green")
      (rectangle cvs 190 140 10 140 "solid" "yellow")
      (rectangle cvs 230 110 10 140 "solid" "green")
      (rectangle cvs 270 140 10 140 "solid" "yellow")
      (rectangle cvs 310 110 10 140 "solid" "green")
      (rectangle cvs 310 240 60 10 "solid" "black")
      (rectangle cvs 320 110 30 10 "solid" "white")
      ;------------------bottom half-----------------------
      (rectangle cvs 70 320 380 10 "solid" "black")
      (rectangle cvs 480 280 10 90 "solid" "yellow")
      (rectangle cvs 70 360 420 10 "solid" "black")
      (rectangle cvs 70 320 10 120 "solid" "yellow")
      (rectangle cvs 110 400 410 10 "solid" "blue")
      (rectangle cvs 70 440 60 10 "solid" "green")
      (rectangle cvs 70 480 30 10 "solid" "blue")
      (rectangle cvs 70 480 30 10 "solid" "black")
      (rectangle cvs 130 440 10 90 "solid" "black")
      (rectangle cvs 170 440 100 10 "solid" "green")
      (rectangle cvs 170 480 60 10 "solid" "green")
      (rectangle cvs 260 440 10 90 "solid" "black")
      (rectangle cvs 260 440 10 90 "solid" "black")
      (rectangle cvs 220 480 10 90 "solid" "yellow")
      )
    ))

cvs
;>>>>>>> 000ee4728e37659bc1952d5611229c8e4602b901
