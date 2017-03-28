god-coefficient is a small proof-of-concept application that demonstrates that a slice of reality can be represented in three dimensions (listed in reverse-order for simplicity):

- A single spacial dimension of any number of sub-dimensions (tic-tac-toe would have {x, y} coordinates, while our world would have {x, y, z}).
- A single time dimension, represented here as "time", that can take the form of traditional temporal progression (e.g. 1 nanosecond, 5 days, 10 years, etc), or any other representation of change (e.g. growth, acceleration, events, etc).
- And a third dimension, which we call the "god coeffecient" to represent a deterministic function that guides the progression of time.

To simplify the example, this final dimension is represented with the RNG seeded with the coefficient value. This means that, while actions are effectively "random", they always result in the same outcomes when rerun.

In simple terms, you can represent (for example) any board state in a game of tic-tac-toe with the coordinate:

    > universe[rng_seed][turn_number]

    X  -  O
    X  O  O
    -  -  O


Similarly, the spacial coordinate can tell us the value of any "spot" on the tic-tac-toe board in that state with:

    > universe[rng_seed][turn_number][x, y]

    'X'

And of course, going the other direction and removing the time dimension results in a deterministic, time-independent universe (game) in which a game _could_ be played out, though only one way (fate, anyone)?

    universe[rng_seed]

    #<Universe::Timeline:0x0056260f815890>