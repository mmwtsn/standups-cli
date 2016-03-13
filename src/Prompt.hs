module Prompt where

import System.Console.ANSI
import System.IO

-- Default text formatting when user is prompted for input
promptColor :: System.Console.ANSI.SGR
promptColor = SetColor Foreground Dull Yellow

-- Reset all text formatting to base Terminal settings
resetColor :: IO ()
resetColor = setSGR [Reset]

-- Prompt user for a line of input with a given prompt string and formatting
getTask :: System.Console.ANSI.SGR -> String -> IO String
getTask sgr prompt = hSetBuffering stdout NoBuffering >>
                     setSGR [sgr] >>
                     putStr prompt >>
                     resetColor >>
                     getLine

-- Prompt user for a given prompt string using the default formatting
promptBase :: String -> IO String
promptBase = getTask promptColor

-- Prompt user for a task category
promptCategory :: IO String
promptCategory = promptBase "  category: "

-- Prompt user for a task action
promptAction :: IO String
promptAction = promptBase "  task: "
