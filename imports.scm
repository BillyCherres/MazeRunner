; imports from billys mini project 6

(import audio)


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