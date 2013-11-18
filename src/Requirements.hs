module Requirements (RequirementType (..), 
                    RequirementId,
                    RequirementDescription,
                    Requirement (..))
where

data RequirementType = UserStory | Defect deriving (Show)
type RequirementId = Int 
type RequirementDescription = String
data Requirement = Requirement {requirementId::RequirementId,
                                requirementType::RequirementType,
                                requirementDescription::RequirementDescription} deriving (Show)

-- TODO
-- Split description into desired fields.