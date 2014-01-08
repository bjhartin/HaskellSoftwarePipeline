module Tests.OldTests where
    import Test.HUnit
    import Pipeline.Pipeline
    import TestData
    import Data.List
    import Questions


    main = runTestTT tests

    tests = TestList [
        -- Core SCM tests

        -- Core component tests
        TestCase (assertEqual "Components are identified by name," applicationA applicationA'),
        TestCase (assertBool "Components with different names are not the same," (applicationA /= applicationA'')),
        TestCase (assertEqual "What are the current source files for component A?," ["src/c.rb", "src/d.rb"] (sourceFiles libraryB)),

        -- Core release tests
        TestCase (assertEqual "Releases are identified by component and version," applicationA_V1_0_0 applicationA_V1_0_0'),
        TestCase (assertBool "Two releases of the same component are not the same," (applicationA_V1_0_0 /= applicationA_V1_0_0'')),
        TestCase (assertBool "Releases of the same component can be sorted by version," (applicationA_V1_0_0 < applicationA_V1_1_0)),

        -- Questions about release dependencies
        TestCase (assertEqual "What are the dependencies for a release (including transitive)?," [libraryA_V1_0_0] (allDependencies libraryB_V1_2_0)),
        TestCase (assertEqual "What are the dependencies for a release (including transitive)?," [libraryA_V1_0_0, libraryB_V1_2_0] (allDependencies applicationA_V1_0_0)),

        -- Questions about what releases are in the repo
        TestCase (assertEqual "What are the releases in the repository for component A?," [applicationA_V1_0_0, applicationA_V1_1_0] (releasesFor artifactRepository applicationA)),
        TestCase (assertEqual "What are all the releases in the repository?" [libraryA_V1_0_0, libraryB_V1_2_0, applicationA_V1_0_0, applicationA_V1_1_0] (allReleases artifactRepository)),
        TestCase (assertEqual "There are no releases of a component prior to the first," Nothing (priorRelease artifactRepository applicationA_V1_0_0)),
        TestCase (assertEqual "What was the release prior to R2?," (Just applicationA_V1_0_0) (priorRelease artifactRepository applicationA_V1_1_0)),
        TestCase (assertEqual "What is the latest release of component A?," (Just applicationA_V1_1_0) (latestRelease artifactRepository applicationA)),
        TestCase (assertEqual "There are no releases for an unreleased component," Nothing (latestRelease artifactRepository libraryC)),


        -- Deployment
        TestCase (assertEqual "Deployment adds release to environment," (DeploymentSuccess (Environment [libraryA_V1_0_0])) (deploy production libraryA_V1_0_0)),
        TestCase (assertEqual "Undeployment removes release from environment," (DeploymentSuccess (Environment [])) (undeploy production libraryA_V1_0_0)),
        TestCase (assertEqual "What releases are deployed in an environment E?," ([applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]) (deployedReleases development)),
        TestCase (assertEqual "What releases of component A are deployed in environment X?," [applicationA_V1_0_0] (filter (\r -> component r == applicationA) (deployedReleases development))),
        TestCase (assertEqual "No deployed releases of queried component," [] (deployedReleasesOf integrationTesting applicationA))
        ]

    applicationA' = Component Library "ApplicationA" libBRootDir -- Same name, but other differences (a problem for later...)
    applicationA'' = Component Application "NotApplicationA" appARootDir -- Different name

    applicationA_V1_0_0' = Release applicationA "1.0.0" [libraryA_V1_0_0] change2 -- Same component and versions, but other diffs
    applicationA_V1_0_0'' = Release libraryA "1.0.0" [] change1 -- Different component/version combo