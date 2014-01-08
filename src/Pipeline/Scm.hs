-- The abstract notion of an SCM system.
--
-- 1. The SCM system has a set of top level
--    directories.
--
-- 2. A commit may apply to files in exactly one
--    top level directory, and any of its subdirectories.
--
--    This is important for traceability - it will make some
--    things vastly simpler.  ScmRootDirs are modeled as
--    a container for commits.
--
--
-- 3. A Component corresponds to exactly one ScmRootDir.
module Pipeline.Scm (ScmRootDir (..),
            Change (..),
            ScmFile,
            Scm (..)) where

    import Pipeline.Requirements
    import Pipeline.User
    import Numeric


    -- Some aliases for readability
    type ScmRevision = Int
    type ScmDescription = String


    -- Basic file system representation.
    -- We take the easy way out here,
    -- and don't worry about a tree structure.
    type ScmFile = String

    -- A specific revision of an object.
    data ScmObjectRevision = ScmObjectRevision ScmFile ScmRevision

    -- Root directories, which (logically) contain commits as well as files and dirs.
    data ScmRootDir = ScmRootDir {scmDirName::String, scmFiles::[ScmFile], scmRootDirChanges::[Change]} deriving (Show, Eq)

    -- A commit.
    data Change = Change {changeScmRevision::ScmRevision,
                          changeDescription::ScmDescription,
                          changeRequirements::[Requirement],
                          changeAuthor::User,
                          changeFiles::[ScmFile]}

    instance Eq Change where
        c == d = changeScmRevision c == changeScmRevision d
    instance Ord Change where
        compare (Change rev1 _ _ _ _) (Change rev2 _ _ _ _) = compare rev1 rev2
    instance Show Change where
        show Change {changeScmRevision = rev, changeDescription = desc} = (show rev) ++ ":" ++ desc

    data Scm = Scm [ScmRootDir]

    allChanges :: Scm -> [Change]
    allChanges (Scm rds) = concatMap scmRootDirChanges rds


-- TODO


-- DESIRED FUNCTONS
--
-- Files for root dir
-- Commits for root dir
-- Commits by user
-- Commits for file
-- Users who modified file
-- Files modified in commit

