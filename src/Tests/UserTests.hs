module Tests.UserTests where
    import Test.HUnit
    import Pipeline.Scm
    import TestData
    import Data.List


    main = runTestTT tests

    tests = TestList [
        -- data User = User {name::String, email::String} deriving (Show, Eq)

        TestCase (assertEqual "Users are comparable" tim tim),
        TestCase (assertEqual "Users are comparable" (tim == brian) False),
        TestCase (assertEqual "Users are displayable" "tim (tandersen@studentloan.org)" (show tim))
        
        ]