module FileSystem where

import System.Directory
import System.FilePath.Posix

-- Prepend file path to ".standups" archive directory
prependPath :: FilePath -> FilePath
prependPath = joinPath . (: [".standups"])

-- Absolute path to the standup's archive directory in "~/.standups"
basePath :: IO FilePath
basePath = getHomeDirectory >>= return . prependPath
