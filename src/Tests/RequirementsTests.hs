module Tests.RequirementsTests where
    import Test.HUnit
    import Pipeline.Requirements
    import TestData

    main = runTestTT tests

    tests = TestList [
        TestCase (assertEqual "A requirement type can be displayed" "Defect" (show Defect)),
        TestCase (assertEqual "A requirement type can be displayed" "UserStory" (show UserStory)),
        TestCase (assertEqual "A requirement type can be compared" False (UserStory == Defect)),
        TestCase (assertEqual "A requirement is identified by id" defect1 (Requirement "defect1" Defect "description")),
        TestCase (assertEqual "A requirement can be displayed" "Defect:defect1" (show defect1))
        ]