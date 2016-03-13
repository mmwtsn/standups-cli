module Main where

import System.Environment
import System.Exit
import Lib

-- Apply user-supplied arguments from ARGV over parser
main :: IO ()
main = getArgs >>= parse

-- Parse input for known commands, flags, or fall through to help
parse :: [String] -> IO ()
parse ["new"]       = new     >> exit
parse ["add-done"]  = addDone >> exit
parse ["add-todo"]  = addTodo >> exit
parse ["standup"]   = standup >> exit
parse ["archive"]   = standup >> exit
parse ["-v"]        = version >> exit
parse ["--version"] = version >> exit
parse ["-h"]        = help    >> exit
parse ["--help"]    = help    >> exit
parse _             = help    >> exit

-- Helper functions for CLI version, usage information, and exit codes
version, help, exit :: IO ()
version = putStrLn "v0.0.2"
help    = putStrLn $
            unlines [ "standups [COMMAND] [-v | --version] [-h | --help]"
                    , ""
                    , "Where COMMAND is one of:"
                    , ""
                    , "  new         Reset the in-progress standup"
                    , "  add-done    Add a task to the in-progress done"
                    , "  add-todo    Add a task to the in-progress todo"
                    , "  standup     Run `add-todo` then archive the standup"
                    , "  archive     Alias for `standup`"
                    ]
exit    = exitWith ExitSuccess
