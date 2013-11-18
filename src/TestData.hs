module TestData where

    import Components
    import Requirements
    import Scm
    import Environment
    import Release
    import User
    import Repository


    -- Set up the users
    tim = User "tim" "tandersen@studentloan.org"
    brian = User "brian" "bhartin@studentloan.org"

    -- Set up the requirements
    defect1 = Requirement 1 Defect "The login screen is broken."
    story2 = Requirement 2 UserStory "The user can change their password."
    story3 = Requirement 3 UserStory "The user can change their email."
    story4 = Requirement 4 UserStory "The user can place an order."
    story5 = Requirement 5 UserStory "The user can cancel an order."


    -- Set up the SCM system.
    appASrcFiles = ["src/a.rb"]
    libASrcFiles = ["src/b.rb"]
    libBSrcFiles = ["src/c.rb", "src/d.rb"]

    -- Handy refs to the files
    a_rb = head appASrcFiles
    b_rb = head libASrcFiles
    c_rb = head libBSrcFiles
    d_rb = tail libBSrcFiles


    -- commits
    commit1 = Commit 1 "Fixed login screen" [defect1] tim [a_rb]
    commit2 = Commit 2 "Added password/email change feature" [story2, story3] brian [b_rb]
    commit3 = Commit 3 "Added password feature" [story2] brian [c_rb]


    -- Scm root dirs
    appARootDir = ScmRootDir "applicationA" appASrcFiles [commit1]
    libARootDir = ScmRootDir "libraryA" libASrcFiles [commit2]
    libBRootDir = ScmRootDir "libraryB" libBSrcFiles [commit3]

    -- Scm system is ready!
    scm = Scm [appARootDir, libARootDir, libBRootDir]


    -- Set up the components
    applicationA = Component Application "ApplicationA" appARootDir
    libraryA = Component Library "LibraryA" libARootDir
    libraryB = Component Library "LibraryB" libBRootDir

    -- Set up some releases    
    applicationA_V1_0_0 = Release applicationA "1.0.0" [libraryA_V1_0_0, libraryB_V1_2_0] commit1
    libraryA_V1_0_0 = Release libraryA "1.0.0" [] commit2
    libraryB_V1_2_0 = Release libraryA "1.2.0" [libraryA_V1_0_0] commit3


    -- Set up the repository
    repository = Repository [applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]

    -- Environments
    development = Environment [applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]
    featureTesting = Environment [applicationA_V1_0_0, libraryA_V1_0_0, libraryB_V1_2_0]
    integrationTesting = Environment [libraryA_V1_0_0, libraryB_V1_2_0]
    production = Environment []
