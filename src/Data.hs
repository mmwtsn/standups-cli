{-# LANGUAGE DeriveGeneric #-}

module Data where

import GHC.Generics
import Data.Aeson

data Task = Task { category :: String
                 , action :: String
                 } deriving (Generic, Show)

instance FromJSON Task
instance ToJSON Task

data Standup = Standup { done :: [Task]
                       , todo :: [Task]
                       } deriving (Generic, Show)

instance FromJSON Standup
instance ToJSON Standup
