module Tests.QuestionTests where
    import Test.HUnit
    import Pipeline.Pipeline
    import TestData
    import Data.List
    import Questions


    main = runTestTT tests

    tests = TestList [
        TestCase (assertEqual "whichRequirementsDroveAChange" [story2, story3] (whichRequirementsDroveAChange change2)),
        TestCase (assertEqual "whichRequirementsAreInARelease" [defect1, story4] (whichRequirementsAreInARelease applicationA_V1_1_0)),
        TestCase (assertEqual "whichRequirementsAreNewForARelease" [story4] (whichRequirementsAreNewForARelease applicationA_V1_0_0 applicationA_V1_1_0)),
        TestCase (assertEqual "whichRequirementsAreDeployedInAnEnvironment" [defect1, story2, story3] (whichRequirementsAreDeployedInAnEnvironment development)),
        TestCase (assertEqual "whichRequirementsAreDeployedInAnEnvironmentForAComponent" [defect1] (concatMap whichRequirementsAreInARelease (deployedReleasesOf development applicationA))),
        TestCase (assertEqual "whichChangesWereMadeForARequirement" [change2, change3, change4] (whichChangesWereMadeForARequirement scm story2)),
        TestCase (assertEqual "whichChangesWereMadeForAComponent" [change3, change4] (whichChangesWereMadeForAComponent libraryB)),
        TestCase (assertEqual "whichChangesAreNotYetReleasedForAComponent" [change6, change7] (whichChangesAreNotYetReleasedForAComponent artifactRepository applicationA)),
        TestCase (assertEqual "WhichChangesAreInARelease" [change1, change5] (whichChangesAreInARelease applicationA_V1_1_0)),
        TestCase (assertEqual "whichChangesAreNewInARelease" [change5] (whichChangesAreNewInARelease applicationA_V1_0_0 applicationA_V1_1_0)),
        TestCase (assertEqual "whichChangesAreNewInARelease" [] (whichChangesAreNewInARelease applicationA_V1_0_0 applicationA_V1_0_0)),
        TestCase (assertEqual "whichChangesAreDeployedInAnEnvironment" [change1, change2, change3] (whichChangesAreDeployedInAnEnvironment development)),
        TestCase (assertEqual "WhoMadeThisChange" tim (whoMadeThisChange change1))
        ]