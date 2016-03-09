module Lib
    ( createStandup
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
createStandup = promptCategory >>= (\c ->
                promptAction   >>= (\a ->
                stashPath      >>= (\path ->
                writeStandup path $ Standup [Task c a] [Task "attn" "do work"])))
