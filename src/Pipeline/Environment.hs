-- The abstract notion of an environment, to which things can be
-- deployed.
module Pipeline.Environment (Environment(..),
                    DeploymentResult(..),
                    deploy,
                    undeploy,
                    deployedReleasesOf,
                    allDeployedChanges) where

    import Pipeline.Release
    import Pipeline.Requirements
    import Pipeline.Component
    import Pipeline.Scm
    import Data.List

    data DeploymentResult = DeploymentSuccess Environment | DeploymentFailure [String] deriving (Show, Eq)

    -- TODO: Need to get transitive dependencies here.
    data Environment = Environment {deployedReleases::[Release]} deriving (Show, Eq)

    deployedReleasesOf::Environment -> Component -> [Release]
    deployedReleasesOf (Environment rs) c = filter (\r -> (component r) == c) rs

    deploy::Environment -> Release -> DeploymentResult
    deploy (Environment rs) r = DeploymentSuccess (Environment (r : rs)) -- simple non-recursive deployment at first.

    undeploy::Environment -> Release -> DeploymentResult
    undeploy (Environment rs) r = DeploymentSuccess (Environment (filter (/= r) rs)) -- simple non-recursive deployment at first.

    allDeployedChanges::Environment -> [Change]
    allDeployedChanges (Environment rs) = concatMap changes rs