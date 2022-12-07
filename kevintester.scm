

(import canvas)
(import html)
; -========================creating the canavas================================
(define cvs (canvas 560 560))

(define color-of-rectangle 
  (vector "white")
  )

(define color-of-inside-walls
  "black"
)
(define color-of-otuside-walls
  "purple"
)

(rectangle cvs 0 0 560 560 "solid" "white")
; creating the white canvas
(animate-with 
  (lambda (time)
    (begin 
      (rectangle cvs 0 0 500 500 "solid" (vector-ref color-of-rectangle 0))
; -----------------start of maze builiding --------------------------------------
      (rectangle cvs 30 30 500 10 "solid" color-of-otuside-walls) 
      (rectangle cvs 30 70 10 450 "solid" color-of-otuside-walls)
      (rectangle cvs 30 520 500 10 "solid" color-of-otuside-walls)
      (rectangle cvs 520 40 10 480 "solid" color-of-otuside-walls)
      ;--------- outer wall ------------
      (rectangle cvs 30 70 350 10 "solid" color-of-inside-walls)
      (rectangle cvs 410 70 110 10 "solid" color-of-inside-walls)
      (rectangle cvs 380 110 120 10 "solid" color-of-inside-walls)
      (rectangle cvs 490 120 10 80 "solid" color-of-inside-walls)
      (rectangle cvs 410 200 90 10 "solid" color-of-inside-walls)
      (rectangle cvs 380 240 140 10 "solid" color-of-inside-walls)
      (rectangle cvs 370 110 10 140 "solid" color-of-inside-walls)
      (rectangle cvs 410 150 10 50 "solid" color-of-inside-walls)
      (rectangle cvs 410 150 50 10 "solid" color-of-inside-walls)
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
      (rectangle cvs 320 110 30 10 "solid" "white")
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
      (rectangle cvs 520 410 10 30 "solid" "white")
      (rectangle cvs 400 400 40 10 "solid" "white")
      (rectangle cvs 440 410 10 40 "solid" color-of-inside-walls)
      (rectangle cvs 390 410 10 40 "solid" color-of-inside-walls)
      )
    ))

cvs

