#lang racket

(require fractalide/modules/rkt/rkt-fbp/agent)

(define-agent
  #:input '("in")
  #:output-array '("out")
   (define in-msg (recv (input "in")))
   (define f (or (try-recv (input "option")) list))
   (for ([msg (f in-msg)])
        (send (hash-ref (output-array "out") (car msg)) (cdr msg))))

(module+ test
  (require rackunit)
  (require syntax/location)

  (require fractalide/modules/rkt/rkt-fbp/def)
  (require fractalide/modules/rkt/rkt-fbp/port)
  (require fractalide/modules/rkt/rkt-fbp/scheduler)

  (test-case
   "Sending message (X . Y) yields message Y on port X"
   (define sched (make-scheduler #f))
   (define tap (make-port 30 #f #f #f))

   (define selection "the-selection")
   (define msg "hello")

   (sched (msg-add-agent "agent-under-test" (quote-module-path ".."))
          (msg-add-agent "identity" 'plumbing/identity)

          (msg-connect-array-to "agent-under-test" "out" selection "identity" "in")
          (msg-raw-connect "identity" "out" tap))

   (sched (msg-mesg "agent-under-test" "in" (cons selection msg)))
   (check-equal? (port-recv tap) msg)
   (sched (msg-stop)))

  (test-case
   "Transform"
   (define sched (make-scheduler #f))
   (define tap (make-port 30 #f #f #f))

   (define selection "the-selection")
   (define msg '(1 2 3 4))

   (sched (msg-add-agent "agent-under-test" (quote-module-path ".."))
          (msg-add-agent "identity" 'plumbing/identity)

          (msg-connect-array-to "agent-under-test" "out" selection "identity" "in")
          (msg-raw-connect "identity" "out" tap))

   (sched (msg-mesg "agent-under-test" "option"
                    (match-lambda [(cons sel data)
                                   (list (cons sel (reverse data)))]))
          (msg-mesg "agent-under-test" "in" (cons selection msg)))
   (check-equal? (port-recv tap) (reverse msg))
   (sched (msg-stop))))
