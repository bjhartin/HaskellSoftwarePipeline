-- The abstract notion of a pipeline...to be fleshed out later.
module Pipeline where

    import Environment
    import Repository
    import Scm

    data Pipeline = Pipeline [Environment] Repository Scm


    -- leadTime
    -- locateRequirement (need more pipeline model)
    -- locateRelease
    -- throughput (need more pipeline model)
