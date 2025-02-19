#lang racket

(require fractalide/modules/rkt/rkt-fbp/graph)

(define-graph
  (node "hp" ${gui.horizontal-panel})
  (edge-out "hp" "out" "out")

  (node "model" ${cardano-wallet.wallet.model})
  (edge-in "in" "model" "in")
  (edge "model" "out" _ "hp" "in" _)

  (node "update" ${cardano-wallet.wallet.update})
  (edge "model" "update" _ "update" "in" _)
  (edge "update" "out" _ "model" "in" _)

  (node "ph" ${gui.place-holder})
  (edge "ph" "out" _ "hp" "place" 2)

  (node "menu" ${gui.vertical-panel})
  (edge "menu" "out" _ "hp" "place" 1)
  (mesg "menu" "in" (cons 'set-stretchable-width #f))

  (node "b-summary" ${gui.button})
  (edge "b-summary" "out" _ "menu" "place" 1)
  (mesg "b-summary" "in" '(init . ((label . "Summary")
                                   (stretchable-width . #t))))
  (mesg "b-summary" "option" (cons 'display #t))
  (node "summary" ${cardano-wallet.wallet.summary})
  (edge "summary" "out" _ "ph" "place" 1)
  (edge "b-summary" "out" 'display "summary" "in" _)

  (node "b-send" ${gui.button})
  (edge "b-send" "out" _ "menu" "place" 2)
  (mesg "b-send" "in" '(init . ((label . "Send")
                                (stretchable-width . #t))))
  (mesg "b-send" "option" (cons 'display #t))
  (node "send" ${cardano-wallet.wallet.send})
  (edge "send" "out" _ "ph" "place" 2)
  (edge "b-send" "out" 'display "send" "in" _)

  (node "b-receive" ${gui.button})
  (edge "b-receive" "out" _ "menu" "place" 3)
  (mesg "b-receive" "in" '(init . ((label . "Receive")
                                   (stretchable-width . #t))))
  (mesg "b-receive" "option" (cons 'display #t))
  (node "receive" ${cardano-wallet.wallet.receive})
  (edge "receive" "out" _ "ph" "place" 3)
  (edge "b-receive" "out" 'display "receive" "in" _)

  (node "b-settings" ${gui.button})
  (edge "b-settings" "out" _ "menu" "place" 10)
  (mesg "b-settings" "in" '(init . ((label . "Settings")
                                    (stretchable-width . #t))))
  (mesg "b-settings" "option" (cons 'display #t))
  (node "settings" ${cardano-wallet.wsettings})
  (edge "settings" "out" _ "ph" "place" 10)
  (edge "b-settings" "out" 'display "settings" "in" _)


  (edge "model" "summary" _ "summary" "in" _)
  (edge "model" "receive" _ "receive" "in" _)
  (edge "model" "settings" _ "settings" "in" _)
)
