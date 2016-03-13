module Prompt where

import System.IO

-- Prompt user for a line of input with a given prompt string and formatting
getTask :: String -> IO String
getTask prompt = hSetBuffering stdout NoBuffering >>
                     putStr prompt >>
                     getLine

-- Prompt user for a task category
promptCategory :: IO String
promptCategory = getTask "  category: "

-- Prompt user for a task action
promptAction :: IO String
promptAction = getTask "  task: "
