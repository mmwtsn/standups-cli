module ReadWrite where

import           Data.Aeson
import qualified Data.ByteString.Lazy as BS
import           GHC.Word
import           Data

-- Decimal value for the ASCII new line character
asciiNewLine :: GHC.Word.Word8
asciiNewLine = 10

-- Append a new line character at the end of a ByteString
appendNewLine :: BS.ByteString -> BS.ByteString
appendNewLine bytestring = BS.snoc bytestring asciiNewLine

-- Encode a Standup as JSON with a new line character appended at the end
encodeWithNewLine :: Standup -> BS.ByteString
encodeWithNewLine standup = appendNewLine $ encode standup

-- Write a JSON-encoded Standup to disk, overwriting the existing file
writeStandup :: Standup -> IO ()
writeStandup standup = BS.writeFile ".in-progress.json" $ encodeWithNewLine standup
