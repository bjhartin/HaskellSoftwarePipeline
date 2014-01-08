-- The abstract notion of a component, releases of which
-- will flow through the pipeline.
--
-- A component could be an application, a configuration,
-- a database, a virtual machine image, a provisioning
-- manifest, a bundle of content assets, etc.  The
-- important idea is that it is a unit of work that
-- has the following qualities.
--
-- 1. A component has a unique name.
-- 2. A component maps to a root directory in Scm.
-- 3. A component has a type, e.g. Application, Configuration
--    Database, etc.
-- 5. A component can be processed according to
--    its type.
-- 6. A component may be released, during which
--    it declares dependencies on other releases,
--    specifies a revision in source control and
--    other information.  See the 'release' module.
module Pipeline.Component (Component (..),
                  ComponentType (..),
                  sourceFiles,
                  allChanges) where

import Pipeline.Scm

data ComponentType = WebApplication |
                   Application |
                       Library |
                 Configuration |
                      Database |
                      Integration
                      deriving (Show, Eq)



type ComponentName = String
data Component = Component {componentType::ComponentType, componentName::ComponentName, componentScmDir::ScmRootDir}
instance Eq Component where c1 == c2 = componentName c1 == componentName c2
instance Show Component where
    show c1 = componentName c1

sourceFiles::Component -> [ScmFile]
sourceFiles (Component {componentScmDir = d}) = scmFiles d

allChanges::Component -> [Change]
allChanges (Component {componentScmDir = d}) = scmRootDirChanges d


-- TODO
--
-- How to guarantee unique name.  This is a tricky problem for a Haskell newbie.
-- Would love to let the compiler enforce this, but I think this might force
-- us down the road of modeling the whole things with types and type computations.
-- That would be fun so I will probably try it at some point.
--
--
-- DESIRED FUNCTONS
--
-- What questions might we want to ask, or operations might we want to perform,
-- on a component but not a specific release.
--
