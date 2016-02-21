module ReadWrite where

import           Data.Aeson
import qualified Data.ByteString.Lazy as BS
import           Data

-- Write a JSON-encoded Standup to disk, overwriting the existing file
writeStandup :: Standup -> IO ()
writeStandup standup = BS.writeFile ".in-progress.json" $ encode standup
