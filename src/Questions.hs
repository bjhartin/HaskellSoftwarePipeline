module Questions(whichRequirementsDroveAChange,
                 whichRequirementsAreInARelease,
                 whichRequirementsAreNewForARelease,
                 whichRequirementsAreDeployedInAnEnvironment,
                 whichRequirementsAreDeployedInAnEnvironmentForAComponent,
                 whichChangesWereMadeForARequirement,
                 whichChangesWereMadeForAComponent,
                 whichChangesAreNotYetReleasedForAComponent,
                 whichChangesAreInARelease,
                 whichChangesAreNewInARelease,
                 whichChangesAreDeployedInAnEnvironment,
                 whoMadeThisChange) where

    import Pipeline.Pipeline
    import Data.List


        -- Naive Pipeline Model
        --
        -- [ScmFile] +---------1 [Component]
        --     1                     1
        --     |                     |
        --     +                     +
        -- [ScmFileRevision] +---1 [Release] +----+ [Environment]
        --     +                   +
        --     |                  /
        --     |                 /
        --     1                1
        --  [change] +---1 [User]
        --     +           1
        --     |          /
        --     |         /
        --     +        +
        --   [Requirement]


        -- This implies over 100 possible functions, for tracing things in the pipeline.
        -- If not for the multiple ways a user is involved, it would be exactly 64 (8*8).
        --
        -- Many of these are uninteresting, so we will implement as needed.
        -- For example, "What requirements were addressed by this release" is f::Release -> [Requirement].
        --
        -- Note that we've made conscious choices that determine the cardinality of the relationships
        -- above.  In some shops, a given file revision might be included in multiple releases.  We assume
        -- that's not the case.


    -- QUESTIONS
    -- =========
    --
    -- Our questions are of three types: traceability, status and pipeline metrics.

    -- Traceability Questions
    -- ===============================

    -- Tracing Back to Requirements
    -- ----------------------------

    -- (Change --> Requirements)
    whichRequirementsDroveAChange::Change -> [Requirement]
    whichRequirementsDroveAChange c = changeRequirements c

    -- (Release --> Requirements)
    whichRequirementsAreInARelease::Release -> [Requirement]
    whichRequirementsAreInARelease r = concatMap (changeRequirements) (changes r)

    -- (Release --> Requirements)
    whichRequirementsAreNewForARelease::Release -> Release -> [Requirement]
    whichRequirementsAreNewForARelease r1 r2 = concatMap (changeRequirements) (differences r1 r2)

    -- (Environment --> Requirements)
    whichRequirementsAreDeployedInAnEnvironment::Environment -> [Requirement]
    whichRequirementsAreDeployedInAnEnvironment (Environment rs) = nub (concatMap whichRequirementsAreInARelease rs)

    whichRequirementsAreDeployedInAnEnvironmentForAComponent::Environment -> Component -> [Requirement]
    whichRequirementsAreDeployedInAnEnvironmentForAComponent e c = nub (concatMap whichRequirementsAreInARelease (deployedReleases e))

    -- Tracing Back to Changes
    -- -----------------------

    -- (Requirement --> Changes)
    whichChangesWereMadeForARequirement:: Scm -> Requirement -> [Change]
    whichChangesWereMadeForARequirement (Scm rds) r = filter (elem r . changeRequirements) changes where
        changes = concatMap scmRootDirChanges rds

    -- (Component --> Changes)
    whichChangesWereMadeForAComponent:: Component -> [Change]
    whichChangesWereMadeForAComponent c = allChanges c

    whichChangesAreNotYetReleasedForAComponent:: Repository -> Component -> [Change]
    whichChangesAreNotYetReleasedForAComponent r c = unreleasedChanges r c

    -- (Release --> Changes)
    whichChangesAreInARelease:: Release -> [Change]
    whichChangesAreInARelease r = changes r

    whichChangesAreNewInARelease:: Release -> Release -> [Change]
    whichChangesAreNewInARelease r1 r2 = differences r1 r2

    -- (Environnet --> Changes)
    whichChangesAreDeployedInAnEnvironment:: Environment -> [Change]
    whichChangesAreDeployedInAnEnvironment e = allDeployedChanges e



    -- Tracing Back to Users
    -- ---------------------

    -- (Change --> User)
    whoMadeThisChange:: Change -> User
    whoMadeThisChange c = changeAuthor c

    -- whoChangedThisFile
    -- whoCreatedThisFileRevision
    -- whoWroteThisRequirement
    -- whoMadeChangesForThisRequirement
    -- whoReleasedThisRelease
    -- whoDeployedThisDeployment



    -- Tracing Back to Files (files being an abstract concept in an SCM system, see file revision)
    -- ---------------------

    -- whichFilesHaveRevisionsForThisChange
    -- whichFilesWereChangedForThisRequirement
    -- whichFilesWereChangedByThisUser
    -- whichFilesExistForThisComponent
    -- whichFilesWereChangedForThisRelease
    -- whichFilesHaveRevisionsAreDeployedInThisEnvironment



    -- Tracing Back to File Revisions (a concept not yet modeled)
    -- ------------------------------

    -- whichFileRevisionsExistForThisFile (history)
    -- whichFileRevisionsWereCreatedForThisRequirement
    -- whichFileRevisionsWereCreatedByThisUser
    -- whichFileRevisionsWereCreatedWithThisChange
    -- whichFileRevisionsBelongToThisComponent
    -- whichFileRevisionsAreIncludedInThisRelease
    -- whichFileRevisionsAreDeployedInThisEnvironment

    -- Tracing Back to Releases
    -- ------------------------

    -- whichReleasesAreDeployedInThisEnvironment *
    -- whichReleaseIntroducedThisChange
    -- whichReleaseIntroducedThisFileRevision
    -- whichReleaseIntroducedThisRequirement *
    -- whichEnvironmentsHaveReleasesOfThisComponent *

    -- Tracing Back to Components
    -- --------------------------

    -- Pipeline Status Questions
    -- =========================

    -- whereIsThisRequirement
    -- whereIsThisRelease
    -- whereIsThisChange
    -- didTheTestsPassForThisRelease
    -- didThisReleaseGetDeployedInAnEnvironment
    -- didThisRequirementGetDeployedInAnEnvironment
    -- hasThisRequirementBeenTested
    -- hasThisChangeBeenTested

    -- Pipeline Metrics/Performance Questions
    -- ======================================

    -- leadTimeBetweenPhasesForRelease
    -- avgLeadTimeBetweenPhases:: Phase -> Phase -> Float
    -- avgLeadTimeBetweenPhasesForComponent:: Component -> Phase -> Phase -> Float
    -- avgLeadTimeBetweenPhasesForTeam:: Team -> Phase -> Phase -> Float
    -- (Possibly other statistics such as variance, mode)
    -- whichRequirementsAreBlocked:: Pipeline -> [Requirement]
    -- whichRequirementsAreBlockedForComponent:: Pipeline -> Component -> [Requirement]
    -- whichRequirementsAreBlockedForTeam:: Pipeline -> Team -> [Requirement]


