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
                                requirementDescription::RequirementDescription}
instance Show Requirement where
        show (Requirement id reqType _) = (show reqType) ++ ":" ++ id

instance Eq Requirement where
        r1 == r2 = (requirementId r1) == (requirementId r2)