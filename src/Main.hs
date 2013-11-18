import Components
import Requirements
import Scm
import Environment
import Release
import User

-- I am using Haskell to model an abstract software delivery pipeline, to
-- explore the important qualities and invariants of such.
main = print ("1")



-- TODO Items:
-- Find commits for component by 'starts with' scm dir
-- How to ensure that components and release versions are unique?
-- How to lookup a component release by component and version?
-- How to represent the repository?
-- How to represent the pipeline?
-- Component versions should be orderable.
-- Tests?



-- requirements test
-- print (map requirementId (requirements scm applicationA_V1_0_0 applicationA_V2_0_0))
-- differences test
-- print (map commitScmRevision (differences scm applicationA_V1_0_0 applicationA_V2_0_0))
-- main = print (map describe (allDependencies applicationA_V1_0_0))
-- main = print (deploy applicationA_V1_0_0 featureTesting)

