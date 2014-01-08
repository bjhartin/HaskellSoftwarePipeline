-- The abstract notion of a pipeline...to be fleshed out later.
module Pipeline.Pipeline(module Pipeline.User,
                         module Pipeline.Requirements,
                         module Pipeline.Scm,
                         module Pipeline.Component,
                         module Pipeline.Release,
                         module Pipeline.Repository,
                         module Pipeline.Environment) where

    import Pipeline.User
    import Pipeline.Requirements
    import Pipeline.Scm
    import Pipeline.Component
    import Pipeline.Release
    import Pipeline.Repository
    import Pipeline.Environment    
    
    

    data Pipeline = Pipeline [Environment] Repository Scm

    -- release function belongs here.  Are phases in the pipline functions?  I think so.
    -- Do they have commonalities?  I think so, especially in their return type.


    -- leadTime
    -- locateRequirement (need more pipeline model)
    -- locateRelease
    -- throughput (need more pipeline model)
