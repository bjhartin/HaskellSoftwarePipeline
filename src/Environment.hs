-- The abstract notion of an environment, to which things can be
-- deployed.
module Environment (Environment(..),
                    DeploymentResult(..)) where


    import Release
    import Requirements

    data DeploymentResult = Success | Failure deriving (Show)
    data Environment = Environment {deployedComponents::[Release]}


    -- DESIRED FUNCTONS
    -- INSIGHT: Need to get transitive dependencies here.
    inventory::Environment -> [Release]
    inventory e = deployedComponents e

    --deployedRequirements::Environment -> [Requirement]
    --deployedRequirements e = concatMap releaseRequirements (inventory e)

    -- INSIGHT: Releases should carry all of their commits, not just the latest.
    -- INSIGHT: We can't just rely on commits for requirements.  A requirement
    -- may be reopened.  Shall we just bundle requirements directly with releases?
    --deployedChanges::Environment -> [Requirement]
    --deployedChanges e = concatMap  (inventory e)