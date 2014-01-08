module Pipeline.Requirements (RequirementType (..), 
                    RequirementId,
                    RequirementDescription,
                    Requirement (..))
where

    

data RequirementType = UserStory | Defect deriving (Show, Eq)
type RequirementId = String 
type RequirementDescription = String
data Requirement = Requirement {requirementId::RequirementId,
                                requirementType::RequirementType,
                                requirementDescription::RequirementDescription} deriving (Eq)
instance Show Requirement where
        show (Requirement id _ desc) = id

-- TODO
-- Split description into desired fields.