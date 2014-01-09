module TestData where

    import Pipeline.Component
    import Pipeline.Requirements
    import Pipeline.Scm
    import Pipeline.Environment
    import Pipeline.Release
    import Pipeline.User
    import Pipeline.Repository


    -- Set up the users
    tim = User "tim" "tandersen@studentloan.org"
    brian = User "brian" "bhartin@studentloan.org"

    -- Set up the requirements
    defect1 = Requirement "defect1" Defect "The login screen is broken."
    story2 = Requirement "story2" UserStory "The user can change their password."
    story3 = Requirement "story3" UserStory "The user can change their email."
    story4 = Requirement "story4" UserStory "The user can place an order."
    story5 = Requirement "story5" UserStory "The user can cancel an order."


    -- Set up the SCM system.
    appASrcFiles = ["src/a.rb"]
    libASrcFiles = ["src/b.rb"]
    libBSrcFiles = ["src/c.rb", "src/d.rb"]
    libCSrcFiles = ["src/e.rb"]

    -- Handy refs to the files
    a_rb = head appASrcFiles
    b_rb = head libASrcFiles
    c_rb = head libBSrcFiles
    d_rb = tail libBSrcFiles
    e_rb = head libCSrcFiles

    -- changes
    change1 = Change 1 "Fixed login screen" [defect1] tim [a_rb]
    change2 = Change 2 "Added password/email support to lib" [story2, story3] brian [b_rb]
    change3 = Change 3 "Added change password support to lib" [story2] tim [c_rb]
    change4 = Change 4 "Added set email links/controller methods" [story2] brian [c_rb]
    change5 = Change 5 "Added links to new javascripts" [story4] brian [a_rb]
    change6 = Change 6 "Added links to new images" [story4] brian [a_rb]
    change7 = Change 7 "Added linkes to new stylesheets" [story4] brian [a_rb]
    change8 = Change 8 "Added stylesheet compression" [story5] brian [e_rb]

    -- Scm root dirs
    appARootDir = ScmRootDir "applicationA" appASrcFiles [change1, change5, change6, change7]
    libARootDir = ScmRootDir "libraryA" libASrcFiles [change2]
    libBRootDir = ScmRootDir "libraryB" libBSrcFiles [change3, change4]
    libCRootDir = ScmRootDir "libraryC" libCSrcFiles [change8]

    -- Scm system is ready!
    scm = Scm [appARootDir, libARootDir, libBRootDir, libCRootDir]

    -- Set up the components
    applicationA = Component Application "ApplicationA" appARootDir
    libraryA = Component Library "LibraryA" libARootDir
    libraryB = Component Library "LibraryB" libBRootDir
    libraryC = Component Library "LibraryC" libCRootDir

    -- Set up some releases
    applicationA_V1_0_0 = Release applicationA "1.0.0" [libraryA_V1_0_0, libraryB_V1_2_0] change1
    libraryA_V1_0_0 = Release libraryA "1.0.0" [] change2
    libraryB_V1_2_0 = Release libraryB "1.2.0" [libraryA_V1_0_0] change3
    applicationA_V1_1_0 = Release applicationA "1.1.0" [libraryA_V1_0_0, libraryB_V1_2_0] change5


    -- Set up the repository
    artifactRepository = Repository [libraryA_V1_0_0, libraryB_V1_2_0, applicationA_V1_0_0, applicationA_V1_1_0]

    -- Environments
    development = Environment [applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]
    featureTesting = Environment [applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]
    integrationTesting = Environment [libraryA_V1_0_0, libraryB_V1_2_0]
    production = Environment []
