Kefir = require 'kefir'
KefirBus = require 'kefir-bus'

module.exports = KefirPoll = (t, pollFn, filterFn, readyFn) ->
    status$ = KefirBus()

    is_ready$ = status$
        .filter filterFn

    poll_status$ = Kefir.interval(t)
        .takeUntilBy is_ready$
        .flatMap pollFn
    status$.plug poll_status$

    is_ready$.take(1).flatMap readyFn

