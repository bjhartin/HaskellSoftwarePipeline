module Pipeline.User (User(..)) where

    data User = User {name::String, email::String} deriving (Eq)

    instance Show User where
        show u = (name u) ++ " (" ++ (email u) ++ ")"
