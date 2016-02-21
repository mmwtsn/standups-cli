module FileSystem where

import System.Directory
import System.FilePath.Posix

-- Absolute path to the standup's archive directory in "~/.standups"
basePath :: IO FilePath
basePath = getHomeDirectory >>= \homeDirectory ->
  return (joinPath [homeDirectory, ".standups"])
