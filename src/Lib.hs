module Lib
    ( addDone
    , addTodo
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
addDone = updateStandup appendDone

-- Prompt user for Task and append it to the current standup's "todo" Task
addTodo :: IO ()
addTodo = updateStandup appendTodo

-- Prompt user for a Task and attempt to update the in-progress Standup with it
updateStandup :: (String -> String -> Standup -> Standup) -> IO ()
updateStandup update = promptCategory >>= \c ->
                       promptAction   >>= \a ->
                       stashPath      >>= \path ->
                       eitherRead c a path update

-- Create a new Task and append it to the end of a Standup's "done" Task
appendDone :: String -> String -> Standup -> Standup
appendDone c a standup = Standup (done standup ++ [Task c a]) (todo standup)

-- Create a new Task and append it to the end of a Standup's "todo" Task
appendTodo :: String -> String -> Standup -> Standup
appendTodo c a standup = Standup (done standup) (todo standup ++ [Task c a])

-- Attempt to read a JSON-encoded Standup from the file system and either print
-- an error if unable to decode it or update it with a given update function
eitherRead :: String -> String -> FilePath
           -> (String -> String -> Standup -> Standup)
           -> IO ()
eitherRead c a path update = readStandup >>= \decoded ->
                    case decoded of
                      Left err      -> putStrLn err
                      Right standup -> writeStandup path $ update c a standup
