module ReadWrite where

import           Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy as BS
import           GHC.Word
import           Data

-- Name for temporary file used while standup is being added to
inProgress :: FilePath
inProgress = ".in-progress.json"

-- Override aeson-pretty's four-space default value, ignore sort function
config :: Data.Aeson.Encode.Pretty.Config
config = Config { confIndent = 2, confCompare = mempty }

-- Decimal value for the ASCII new line character
asciiNewLine :: GHC.Word.Word8
asciiNewLine = 10

-- Append a new line character at the end of a ByteString
appendNewLine :: BS.ByteString -> BS.ByteString
appendNewLine bytestring = BS.snoc bytestring asciiNewLine

-- Encode a Standup as JSON with a new line character appended at the end
encodeWithNewLine :: Standup -> BS.ByteString
encodeWithNewLine standup = appendNewLine $ encodePretty' config standup

-- Write a JSON-encoded Standup to disk, overwriting the existing file
writeStandup :: Standup -> IO ()
writeStandup standup = BS.writeFile inProgress $ encodeWithNewLine standup

-- Read a JSON-encoded standup from disk without parsing it
readStandup :: IO BS.ByteString
readStandup = BS.readFile inProgress
