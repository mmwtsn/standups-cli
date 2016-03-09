module ReadWrite where

import           Data.Aeson
import           Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy as BS
import           GHC.Word
import           Data
import           FileSystem

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
writeStandup :: FilePath -> Standup -> IO ()
writeStandup path standup = (BS.writeFile path $ encodeWithNewLine standup)
                            >> putStr "Updated: \""
                            >> putStr path
                            >> putStrLn "\""

-- Read and parse a JSON-encoded standup from disk
readStandup :: IO (Either String Standup)
readStandup = fmap eitherDecode . BS.readFile =<< stashPath
