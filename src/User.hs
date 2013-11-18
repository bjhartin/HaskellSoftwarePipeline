module User (User(..)) where

    data User = User {name::String, email::String} deriving (Show, Eq)
