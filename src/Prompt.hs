module Prompt where

import System.Console.ANSI
import Data

-- Default text formatting when user is prompted for input
promptColor :: System.Console.ANSI.SGR
promptColor = SetColor Foreground Dull Yellow

-- Reset all text formatting to base Terminal settings
resetColor :: IO ()
resetColor = setSGR [Reset]

-- Prompt user for a line of input with a given prompt string and formatting
getTask :: System.Console.ANSI.SGR -> String -> IO String
getTask sgr prompt = setSGR [sgr] >>
                     putStr prompt >>
                     resetColor >>
                     getLine

-- Prompt user for a given prompt string using the default formatting
promptBase :: String -> IO String
promptBase = getTask promptColor

-- Prompt user for a task category
promptCategory :: IO String
promptCategory = promptBase "Category? "

-- Prompt user for a task action
promptAction :: IO String
promptAction = promptBase "Task?     "

-- Create a new instance of Standup from user input with a default done Task
createStandup :: IO ()
createStandup = promptCategory >>= (\c ->
                promptAction   >>= (\a ->
                print $ Standup [Task c a] [Task "attn" "do work"]))
