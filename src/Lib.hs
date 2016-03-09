module Lib
    ( addDone
    , createStandup
    , someFunc
    ) where

import Data
import FileSystem
import Prompt
import ReadWrite

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Create a new instance of Standup from user input with a default done Task
createStandup :: IO ()
createStandup = promptCategory >>= \c ->
                promptAction   >>= \a ->
                stashPath      >>= \path ->
                writeStandup path $ Standup [Task c a] [Task "attn" "do work"]

-- Prompt user for Task and append it to the current standup's "done" Task
addDone :: IO ()
addDone = promptCategory >>= \c ->
          promptAction   >>= \a ->
          stashPath      >>= \path ->
          eitherRead c a path appendDone

-- Create a new Task and append it to the end of a Standup's "done" Task
appendDone :: String -> String -> Standup -> Standup
appendDone c a standup = Standup (done standup ++ [Task c a]) (todo standup)

-- Attempt to read a JSON-encoded Standup from the file system and either print
-- an error if unable to decode it or update it with a given update function
eitherRead :: String -> String -> FilePath
           -> (String -> String -> Standup -> Standup)
           -> IO ()
eitherRead c a path update = readStandup >>= \decoded ->
                    case decoded of
                      Left err      -> putStrLn err
                      Right standup -> writeStandup path $ update c a standup
