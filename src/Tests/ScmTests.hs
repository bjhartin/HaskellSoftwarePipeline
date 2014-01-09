module Tests.ScmTests where
    import Test.HUnit
    import Pipeline.Scm
    import TestData
    import Data.List


    main = runTestTT tests

    tests = TestList [
        TestCase (assertEqual "Scm root dirs are identified by dir name" libARootDir (ScmRootDir "libraryA" [] [])),
        TestCase (assertEqual "Scm root dirs can be displayed" "libraryA" (show libARootDir)),
        TestCase (assertEqual "Changes are identified by revision" change1 (Change 1 "Message" [] brian [])),
        TestCase (assertEqual "Changes are ordered by revision" LT (compare change1 change2)),
        TestCase (assertEqual "Changes are ordered by revision" EQ (compare change1 change1)),
        TestCase (assertEqual "Changes are ordered by revision" GT (compare change2 change1)),
        TestCase (assertEqual "Changes can be displayed" "1:Fixed login screen" (show change1))
        ]