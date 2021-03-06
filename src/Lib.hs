module Lib
    ( new
    , addDone
    , addTodo
    , standup
    ) where

import Data
import FileSystem
import Prompt
import ReadWrite

-- Boilerplate messages for prompting user for input
pastMessage, futureMessage :: String
pastMessage   = "What did you do since last standup?\n"
futureMessage = "What will you do until the next standup?\n"

-- Create a new instance of Standup from user input with a default done Task
new :: IO ()
new = putStrLn pastMessage >>
      promptCategory >>= \c ->
      promptAction   >>= \a ->
      stashPath      >>= \path ->
      writeStandup path $ Standup [Task c a] [Task "life" "write Haskell!"]

-- Prompt user for Task and append it to the current standup's "done" Task
addDone :: IO ()
addDone = updateStandup pastMessage stashPath appendDone

-- Prompt user for Task and append it to the current standup's "todo" Task
addTodo :: IO ()
addTodo = updateStandup futureMessage stashPath appendTodo

-- Remove the default "todo" Task and archive the in-progress standup
standup :: IO ()
standup = updateStandup futureMessage archivePath replaceDefaultTodo

-- Prompt user for a Task and attempt to update the in-progress Standup with it
updateStandup :: String -> IO FilePath
              -> (String -> String -> Standup -> Standup)
              -> IO ()
updateStandup header filePath update = putStrLn header >>
                                promptCategory >>= \c ->
                                promptAction   >>= \a ->
                                filePath       >>= \path ->
                                eitherRead c a path update

-- Create a new Task and append it to the end of a Standup's "done" Task
appendDone :: String -> String -> Standup -> Standup
appendDone c a standup = Standup (done standup ++ [Task c a]) (todo standup)

-- Create a new Task and append it to the end of a Standup's "todo" Task
appendTodo :: String -> String -> Standup -> Standup
appendTodo c a standup = Standup (done standup) (todo standup ++ [Task c a])

-- Remove the default "todo" Task at the head of the Task list
replaceDefaultTodo :: String -> String -> Standup -> Standup
replaceDefaultTodo c a standup = Standup (done standup) (todos ++ [Task c a])
                                 where todos = tail $ todo standup

-- Attempt to read a JSON-encoded Standup from the file system and either print
-- an error if unable to decode it or update it with a given update function
eitherRead :: String -> String -> FilePath
           -> (String -> String -> Standup -> Standup)
           -> IO ()
eitherRead c a path update = readStandup >>= \decoded ->
                               case decoded of
                                 Left err      -> putStrLn err
                                 Right standup ->
                                   writeStandup path $ update c a standup
