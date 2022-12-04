
(import audio)


(define ctx (audio-context 44100))
(audio-pipeline ctx 
  (microphone-node ctx)
  )