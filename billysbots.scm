; 
; CSC 151 Group project final
;
; Kevin Johanson, Breck Bishop, Billy Cherries
;
; 
; Acknowledgements: Some Code taken from BILLY AND KEVIN'S mini proj 6 BILLY AND KEVINS
;
;




; step 1: figure out how to take an audio input
; step 2: import mini proj 6 that plays a sound based on a vector
; step 3: make new sound envelopes for the voice changer options
;
;




(import audio)

; ====================================================
; *************** import mini proj 6 *****************
; ======================================================
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
; (define new-synthesize-note
;   (lambda (waveform sample-rate frequency duration asdr-list)
    
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
    
    
; ======================================NEW IMPORTS==================================================
; ===============Helper functions ===============
; (samples-per-wave sample-rate frequency) integer?
;sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
; returns the number of samples in a given wave based off the sample-rate and frequency of the eave
(define samples-per-wave
  (lambda (sample-rate frequency)
    (/ sample-rate frequency )))

; (waves-per-clip sample-rate duration frequency) integer?
;sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
;duration: number?, a non-negative number
; returns the number of waves per clip based off the sample-rate duration and frequency
(define waves-per-clip
  (lambda (sample-rate duration frequency)
    (/ (* sample-rate duration) (/ sample-rate frequency) )))
; ===============Square sample=================
; (index->square-sample n clip-samples): integer
; n: integer? positive number
; clip-sanples: integer? positive
; returns -1 if the index in the vector is less then the clip samples divided by 2 and returns 1 if not
(define index->square-sample
  (lambda (n clip-samples)
    (if (< n (/ clip-samples 2))
      -1
      1)))

; (square-sample sample-rate frequency duration): vector?
;sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
; duration: number?, a non-negative number
; returns the square pattern in the form of a vector
(define square-sample
  (lambda (sample-rate frequency duration)
    (let* ([wave-samples (samples-per-wave sample-rate frequency)]
        [clip-waves (waves-per-clip sample-rate duration frequency)]) 
      (vector-map 
        (lambda (n) (index->square-sample (remainder n wave-samples) wave-samples)) 
        (vector-range 0 (* wave-samples clip-waves))))))


;===================Sawtooth wave===================
; (index->sawtooth-sample n clip-samples): integer
; n: integer? positive number
; clip-sanples: integer? positive
; creates the sawtooth pattern over a given index
(define index->sawtooth-sample
  (lambda (n clip-samples)
    (* -1 (+ -1 (/ n (* clip-samples 0.5))))))

; (sawtooth-sample sample-rate frequency duration): vector?
; sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
; duration: number?, a non-negative number
; returns the sawtooth pattern in the form of a vector
(define sawtooth-sample
  (lambda (sample-rate frequency duration)
    (let* ([wave-samples (samples-per-wave sample-rate frequency)]
        [clip-waves (waves-per-clip sample-rate duration frequency)]) 
      (vector-map 
        (lambda (n) (index->sawtooth-sample (remainder n wave-samples) wave-samples)) 
        (vector-range 0 (* wave-samples clip-waves))))))

;===================Triangle wave==============================
; (index->triangle-sample n clip-samples): integer
; n: integer? positive number
; clip-sanples: integer? positive
; creates the triangle pattern over a given index
(define index->triangle-sample
  (lambda (n clip-samples)
    (if (< n (/ clip-samples 2))
      (+ -1 (* 2 (* -1 (+ -1 (/ n (* .5 clip-samples))))))
      (+ -1 (* 2 (+ -1 (/ n (* .5 clip-samples))))))))


; (triangle-sample sample-rate frequency duration): vector?

;sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
;duration: number?, a non-negative number
; returns the triangle pattern in the form of a vector
(define triangle-sample
  (lambda (sample-rate frequency duration)
    (let* ([wave-samples (samples-per-wave sample-rate frequency)]
        [clip-waves (waves-per-clip sample-rate duration frequency)]) 
      (vector-map 
        (lambda (n) (index->triangle-sample (remainder n wave-samples) wave-samples)) 
        (vector-range 0 (* wave-samples clip-waves))))))

;==================Sine wave================================
(define pi 3.14159265359)
; (index->sine-sample n clip-samples): integer
; n: integer? positive number
; clip-sanples: integer? positive
; creates the sine pattern over a given index
(define index->sine-sample
  (lambda (n clip-samples)
    (sin (* 2 pi (/ n clip-samples)))))

; (sine-sample sample-rate frequency duration): vector?

;sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
;duration: number?, a non-negative number
; returns the sine pattern in the form of a vector
(define sine-sample
  (lambda (sample-rate frequency duration)
    (let* ([wave-samples (samples-per-wave sample-rate frequency)]
        [clip-waves (waves-per-clip sample-rate duration frequency)]) 
      (vector-map 
        (lambda (n) (index->sine-sample (remainder n wave-samples) wave-samples)) 
        (vector-range 0 (* wave-samples clip-waves))))))
; ========================apply Envelope==================================
; (apply-envelope clip envelope) vector?
; clip: vector? length is the same as the envelope
; envelope: vector? length is the same as the clip
; creates a new vector out of the multiplication of the 2 given vectors
(define apply-envelope
  (lambda (clip envelope)
    (vector-map * clip envelope)))
; ========================Simple Envelope==================================
; (simple-envelope n) vector
; n : integer
; creates a vector with vector-range function 
(define simple-envelope
  (lambda (n)
    (vector-map (lambda (x) (- .5 (/ x (* 2 n))) ) (vector-range 0 n))))

; (simple-envelope 10)
; (vector-range 0 10)

; ========================Synthesize note==================================
; (synthesize-note waveform sample-rate frequency duration): vector
;waveform: string? one of "square", "sawtooth", "triangle", or "sine"
; sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
; duration: number?, a non-negative number
; returns the specified waveform in the form of a vector
(define synthesize-note
  (lambda (waveform sample-rate frequency duration)
    (cond [(equal? waveform "square") (square-sample sample-rate frequency duration)]
      [(equal? waveform "sawtooth") (sawtooth-sample sample-rate frequency duration)]
      [(equal? waveform "triangle") (triangle-sample sample-rate frequency duration)]
      [(equal? waveform "sine") (sine-sample sample-rate frequency duration)]
      [else "not valid waveform"])))
; ========================Synthesize noteS==================================
; (synthesize-notes waveform sample-rate frequency duration n) -> vector?
;waveform: string? one of "square", "sawtooth", "triangle", or "sine"
; sample-rate: number?, a non-negative integer
;frequency: number?, a non-negative number
; duration: number?, a non-negative number
; n: number?, a non-negative integer
;Returns a vector of samples representing n notes syntheiszed from the given
; parameters.
(define synthesize-notes
  (lambda (waveform sample-rate frequency duration n)
    (let* ([clip (synthesize-note waveform sample-rate frequency duration)]
        [clip-samples (* (samples-per-wave sample-rate frequency) (waves-per-clip sample-rate duration frequency))]
        [one-note-envelope (simple-envelope (/ clip-samples n))])
      (vector-map 
        (lambda (i) (* (vector-ref clip i) (vector-ref one-note-envelope (remainder i (/ clip-samples n))))) 
        (vector-range clip-samples)))))

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

























