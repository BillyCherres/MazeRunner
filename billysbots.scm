; 
; CSC 151 Group project final
;
; Kevin Johanson, Breck Bishop, Billy Cherries
;
; 
; Acknowledgements: Some Code taken from mini proj 6
;
;




; step 1: figure out how to take an audio input
; step 2: import mini proj 6 that plays a sound based on a vector
; step 3: make new sound envelopes for the voice changer options
;
;




(import audio)


; *************** import mini proj 6 *****************
;
;


; (apply-envelope clip envelope) --> vector
; clip : vector?
; envelope : vector?
;
; takes two vectors and multiplies them in a pointwise mannor

  (define apply-envelope
  (lambda (clip envelope)
      (vector-map (lambda (x n) (* x n)) clip envelope)
    ))


; (add-envelope clip envelope) --> vector
; clip : vector?
; envelope : vector?
;
; takes two vectors and adds them in a pointwise mannor
(define add-envelope
  (lambda (clip envelope)
      
       (vector-map (lambda (x n) (+ x n)) clip envelope)
      
    ))


; (mini-vect vec n) -> vector
; vec : vector?
; n: integer?
; 
; helper function for synthesize-notes
(define mini-vect 
(lambda (vec n)
    (list->vector 
      (list-take 
        (vector->list vec) 
        (/ (length (vector->list vec)) n)
      ))
)
)


; (new-vect vec n) -> vector
; vec : vector?
; n: integer?
; 
; helper function for synthesize-notes
(define new-vect 
    (lambda (vec n)
        (apply append (make-list n (vector->list vec)))
    )
)

; (final-vect vec n) ->vector
; vec : vector?
; n: integer?
; 
; helper function for synthesize-notes
(define final-vect 
    (lambda (vec n)
        (list->vector (new-vect (mini-vect vec n) n))
    )
)

; (add-vect vec-list) --> vector
; vec-list : list of vectors
;
; functions adds a list of vectors together pointwise addition style

(define add-vect
  (lambda (vec-list) 
    (match vec-list
    [(cons head null) head]
    [(cons head tail) (add-envelope head (add-vect tail))]

    )
  )
)


; (add-vect vec-list) --> vector
; vec : vector?
;
; functions cuts any value that is above 1 to 1 and any value below -1 to -1 in a vector

(define cut-vect
  (lambda (vec)
    (vector-map (lambda (x) (cond [(> x 1) 1] [(< x -1) -1] [else x])) vec)
  )
)


; (add-and-cut vec-list) --> vector
; vec : vector?
;
; functions calls add-vect and then cut-vect on a list of vectors
(define add-and-cut 
  (lambda (vec-list)
    (cut-vect (add-vect vec-list))
  )
)

; (new-synthesize-note waveform sample-rate frequency duration asdr-list) --> vector
; waveform : string?
; sample-rate : integer?
; frequency : integer?
; duration : integer?
; asdr-list : list?
;
; creates a vector that plays one of four waves with asdr-envelope applied to it when sample-node is played over it
(define new-synthesize-note
  (lambda (waveform sample-rate frequency duration asdr-list)
    
    (let* ([num-sample (* duration sample-rate)])
    
     (cond 
                                                    ;   all ~~~-samples are a list of vectors and will be replaced by the microphone vector
                                                    ;   asdr-envelope will be replaced with the sound modifier that we have yet to produce
          [(equal? waveform "square")  (apply-envelope (square-sample sample-rate frequency duration) (asdr-envelope num-sample asdr-list))]
          [(equal? waveform "sawtooth") (apply-envelope (sawtooth-sample sample-rate frequency duration) (asdr-envelope num-sample asdr-list))]
          [(equal? waveform "triangle") (apply-envelope (square-sample sample-rate frequency duration) (asdr-envelope num-sample asdr-list))]
          [(equal? waveform "sine") (apply-envelope (sine-sample sample-rate frequency duration) (asdr-envelope num-sample asdr-list))]

      )

    )
    
    ))

;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;********************************************************








(define deep-voice-envelope 
(lambda (end)
"vector"
))


(define high-voice-envelope 
(lambda (end)
"vector"
))


(define robot-voice-envelope 
(lambda (end)
"vector"
))


(define slow-voice-envelope 
(lambda (end)
"vector"
))

(define fast-voice-envelope 
(lambda (end)
"vector"
))


(define delayed-voice-envelope 
(lambda (end)
"vector"
))

(define overlayed-voice-envelope 
(lambda (end)
"vector"
))

























