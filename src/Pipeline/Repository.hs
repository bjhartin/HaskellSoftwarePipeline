module Pipeline.Repository(Repository(..),
                  addRelease,
                  priorRelease,
                  latestRelease,
                  otherReleases,
                  releasesFor,
                  unreleasedChanges) where

    import Pipeline.Component
    import Pipeline.Release
    import Pipeline.Scm
    import Pipeline.User
    import Data.List

    data Repository = Repository {allReleases::[Release]}

    addRelease::Repository -> Release -> Repository
    addRelease (Repository rs) r = Repository (r:rs)

    priorRelease::Repository -> Release -> Maybe Release
    priorRelease r r1 = headMaybe (sort earlierReleases) where
        earlierReleases = filter (<r1) (otherReleases r r1)

    otherReleases::Repository -> Release -> [Release]
    otherReleases r@(Repository rs) r1 = filter (/= r1) (releasesFor r (component r1))

    releasesFor::Repository -> Component -> [Release]
    releasesFor (Repository rs) c = filter (\r -> (component r) == c) rs

    latestRelease::Repository -> Component -> Maybe Release
    latestRelease r c = headMaybe (desort (releasesFor r c))

    unreleasedChanges::Repository -> Component -> [Change]
    unreleasedChanges r c = case (latestRelease r c) of
        Nothing -> allChanges c
        Just latestRelease -> dropWhile (<= lastChange) (allChanges c) where
            lastChange = lastChangeInRelease latestRelease

    headMaybe :: (Ord a) => [a] -> Maybe a
    headMaybe []     = Nothing
    headMaybe (x:xs) = Just x

    desort = reverse . sort


