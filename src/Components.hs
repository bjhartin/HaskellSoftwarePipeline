-- The abstract notion of a component, releases of which
-- will flow through the pipeline.
--
-- 1. Each component has a unique name.
-- 2. Each component maps to a root directory in Scm.
--    INSIGHT: branches are new components
-- 3. Each component has a type, e.g. Application.
module Components (Component (..),
                   ComponentType (..)) where

import Scm

data ComponentType = WebApplication |
                   Application |
                       Library |
                 Configuration |
                      Database |
                      Integration
                      deriving (Show, Eq)



type ComponentName = String
data Component = Component {componentType::ComponentType, componentName::ComponentName, componentScmDir::ScmRootDir} deriving (Show)
instance Eq Component where c1 == c2 = componentName c1 == componentName c2

-- TESTS / TYPE CONSTRAINTS
--
-- Create a component
-- Compare two components
-- Ensure ScmDir is '//something'.
--   Alternately, ensure ScmDir comes from Scm (introduces dependency on Scm)

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
-- sourceFilesForComponent::Scm -> Component -> [File]
-- allWorkForComponent::Component -> [Commit]
-- unreleasedWorkForComponent::Repository -> Component -> [Commit]
-- releasesForComponent::Component -> [Release]
-- deploymentsForComponent::Component -> [Deployment]