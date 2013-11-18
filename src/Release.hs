-- The abstract notion of a release of a component.
--
-- 1. Each release is uniquely identified by a 
--    component name and version.
-- 2. Each release expresses dependencies on other releases.
-- 3. Releases are orderable, i.e. we can ask 'Which came first, r1 or r2?'
-- 4. Releases are mapped to the most recent commit to that component's
--    SCM dir.
module Release (Release(..),
                allDependencies) where

    import Components
    import Scm

    type ComponentVersion = String
    data Release = Release {component::Component,
                                          componentVersion::ComponentVersion,
                                          componentDependencies::[Release],
                                          componentLastCommit::Commit} deriving (Show)

-- TESTS / TYPE CONSTRAINTS
--
-- Create a release
-- Compare two releases

-- TODO
--
-- How to guarantee unique component + version.  This is a tricky problem for a Haskell newbie.
-- Would love to let the compiler enforce this, but I think this might force
-- us down the road of modeling the whole things with types and type computations.
-- That would be fun so I will probably try it at some point.
--
--
-- DESIRED FUNCTONS
--
-- What questions might we want to ask, or operations might we want to perform,
-- on a release.
--
-- sourceFilesInRelease::Scm -> Release -> [File]
-- contributorsToRelease::Release -> [User]

-- deploymentsForRelease::Release -> [Deployment]

    -- deploy:: Release -> Environment -> Deployment
    -- deploy _ _ = Success -- We rule!

    -- Get all dependencies, including transitive ones
    allDependencies::Release -> [Release]
    allDependencies c@(Release {componentDependencies = x:xs}) = c : (concatMap allDependencies (x:xs))
    allDependencies c = [c]

    -- Describe component releases
    describe::Release -> (String, String)
    describe cr = (componentName (component cr) , componentVersion cr)

    -- Determine if two component releases are for the same component
    --sameComponent::Release -> Release -> Bool
    --sameComponent cr1 cr2 = component cr1 == component cr2

    -- changesInRelease::Component -> ComponentVersion -> ComponentVersion -> [Commit]
    -- Get the commits between two releases of the same component
    -- DOES NOT WORK - Will capture commits in between that may not apply to these components.
    -- HOW to map commits to components?
    --differences::Scm -> Release -> Release -> [Commit]
    --differences (Scm commits) cr1 cr2 | sameComponent cr1 cr2 = filter inRange commits where
    --    inRange c = (c >= componentLastCommit cr1) && (c <= componentLastCommit cr2)

    -- requirementsInRelease::Component -> ComponentVersion -> ComponentVersion -> [Requirement]
    -- Get the requirements addressed in the commits between two releases
    --requirements::Scm -> Release -> Release -> [Requirement]
    --requirements scm cr1 cr2 = concatMap commitRequirements (differences scm cr1 cr2)
    
    

    --acceptanceTest::ComponentRelease -> Environment -> TestResult -- Test data is a component, deployed by the deployer
    --leadTime::Pipeline -> ComponentRelease -> Phase -> Phase -> Float

