-- The abstract notion of a release of a component.
--
-- 1. Each release is uniquely identified by a 
--    component name and version.
-- 2. Each release expresses dependencies on other releases.
-- 3. Releases are orderable, i.e. we can ask 'Which came first, r1 or r2?'
-- 4. Releases are mapped to the most recent commit to that component's
--    SCM dir.
module Pipeline.Release (Release(..),
                changes,
                differences,
                allDependencies,
                sameComponent) where

    import Pipeline.Component
    import Pipeline.Scm
    import Pipeline.Requirements
    import Data.List
    
    type ComponentVersion = String
    data Release = Release {component::Component,
                                          componentVersion::ComponentVersion,
                                          componentDependencies::[Release],
                                          lastChangeInRelease::Change}

    instance Eq Release where
        r1 == r2 = component r1 == component r2 && componentVersion r1 == componentVersion r2

    instance Ord Release where
        r1 <= r2 = component r1 == component r2 && componentVersion r1 <= componentVersion r2

    instance Show Release where
        show r1 = componentName (component r1) ++ ":" ++ componentVersion r1

    sameComponent::Release -> Release -> Bool
    sameComponent (Release {component = c1}) (Release {component = c2}) = c1 == c2

-- TODO
-- How to guarantee unique component + version.  This is a tricky problem for a Haskell newbie.
-- Would love to let the compiler enforce this, but I think this might force
-- us down the road of modeling the whole things with types and type computations.
-- That would be fun so I will probably try it at some point.
--
-- sourceFilesInRelease::Scm -> Release -> [File] -- May need to add concept of revision to ScmFile
-- contributorsToRelease::Release -> [User]
-- deploymentsForRelease::Pipeline -> Release -> [Deployment]

    -- Get all dependencies, including transitive ones
    allDependencies::Release -> [Release]
    allDependencies r@(Release {componentDependencies = x:xs}) =
        uniqAppend (x:xs)  (concatMap allDependencies (x:xs)) where
            uniqAppend xs ys = nub (foldr (:) ys xs)
    allDependencies r = [] -- r has no dependencies

    changes::Release -> [Change]
    changes Release {component = Component {componentScmDir = d}, lastChangeInRelease = cm} = filter (<= cm) (scmRootDirChanges d)

    differences::Release -> Release -> [Change]
    differences r1 r2 = (changes r2) \\ (changes r1)

   

    -- Determine if two component releases are for the same component
    --sameComponent::Release -> Release -> Bool
    --sameComponent cr1 cr2 = component cr1 == component cr2

    --differences::Scm -> Release -> Release -> [Commit]
    --differences (Scm commits) cr1 cr2 | sameComponent cr1 cr2 = filter inRange commits where
    --    inRange c = (c >= componentLastCommit cr1) && (c <= componentLastCommit cr2)

    -- requirementsInRelease::Component -> ComponentVersion -> ComponentVersion -> [Requirement]
    -- Get the requirements addressed in the commits between two releases
    --requirements::Scm -> Release -> Release -> [Requirement]
    --requirements scm cr1 cr2 = concatMap commitRequirements (differences scm cr1 cr2)

    --acceptanceTest::ComponentRelease -> Environment -> TestResult -- Test data is a component, deployed by the deployer
    --leadTime::Pipeline -> ComponentRelease -> Phase -> Phase -> Float