{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module Routes.Users
  ( AllUsers
  , User(..)
  )
where

import Data.Time
import Data.Aeson
import Data.Aeson.Types
import GHC.Generics
import Servant.API

data User = User
  { name :: String
  , age :: Int
  , email :: String
  , registration_date :: Day
  } deriving (Eq, Show, Generic)

instance ToJSON User

type AllUsers = "users" :> Get '[JSON] [User]

-- data SortBy = Age | Name

-- type UserAPI1 = "users" :> QueryParam "sortby" SortBy :> Get '[JSON] [User]

-- type UserAPI2 = "users" :> QueryParam "name" String :> Get '[JSON] User

-- type UserAPI3 = "users" :> Capture "userid" Integer :> Get '[JSON] User
