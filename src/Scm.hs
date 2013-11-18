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
--    INSIGHT: Commit hook?
--
-- 3. A Component corresponds to exactly one ScmRootDir.
module Scm (ScmRootDir (..),
            Commit (..),
            ScmFile,
            Scm (..)) where

    import Requirements
    import User


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
    data ScmRootDir = ScmRootDir {scmDirName::String, scmFiles::[ScmFile], scmRootDirCommits::[Commit]} deriving (Show, Eq)

    -- A commit.
    data Commit = Commit {commitScmRevision::ScmRevision,
                          commitDescription::ScmDescription,
                          commitRequirements::[Requirement],
                          commitAuthor::User,
                          commitFiles::[ScmFile]} deriving (Show)

    instance Eq Commit where
        c == d = commitScmRevision c == commitScmRevision d
    instance Ord Commit where
        c `compare` d = commitScmRevision c `compare` commitScmRevision d

    data Scm = Scm [ScmRootDir]

-- TODO


-- DESIRED FUNCTONS
--
-- Files for root dir
-- Commits for root dir
-- Commits by user
-- Commits for requirement
-- Commits for file
-- Users who modified file
-- Files modified in commit

