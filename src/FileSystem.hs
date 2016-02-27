module FileSystem where

import Data.Time
import System.Directory
import System.FilePath.Posix

-- Prepend file path to ".standups" archive directory
prependPath :: FilePath -> FilePath
prependPath = joinPath . (: [".standups"])

-- Absolute path to the standup's archive directory in "~/.standups"
basePath :: IO FilePath
basePath = getHomeDirectory >>= return . prependPath

-- Format a time stamp like "1947-01-08-Wednesday.json"
formatTimeStamp :: ZonedTime -> String
formatTimeStamp = formatTime defaultTimeLocale "%F-%A.json"

-- Build time-stamped file name for today's standup
currentFileName :: IO String
currentFileName = getZonedTime >>= return . formatTimeStamp
