module FileSystem where

import Data.Time
import System.Directory
import System.FilePath.Posix

-- Format archive name so it's sortable and legible: "2016-12-31-Thursday.json"
formatArchiveFileName :: ZonedTime -> String
formatArchiveFileName = formatTime defaultTimeLocale "%F-%A.json"

-- Time-stamped file name for today's standup for the caller's time zone
archiveFileName :: IO FilePath
archiveFileName = fmap formatArchiveFileName getZonedTime

-- Absolute path to a user's archive directory: "~/.standups"
basePath :: FilePath -> IO FilePath
basePath file = getHomeDirectory >>= \home ->
                return $ joinPath [home, ".standups", file]

-- Absolute file path to the stash file where in-progress standup data is saved
stashPath :: IO FilePath
stashPath = basePath ".in-progress.json"

-- Absolute file path to the archive file where finished standups are saved
archivePath :: IO FilePath
archivePath = archiveFileName >>= basePath
