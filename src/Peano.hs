module Peano where

    -- Peano numbers example (Will explain this later)
    data After t
    type Zero = After ()
    type One = After Zero
    type Two = After One
    type Three = After Two
    type Four = After Three
    type Five = After Four
    type Six = After Five
    type Seven = After Six
    type Eight = After Seven
    type Nine = After Eight
