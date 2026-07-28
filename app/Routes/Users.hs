{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module ApiType
  (
    UsersAPI
  , SortBy
  , User(..)
  )
where

import Data.Text
import Data.Time (UTCTime)
import Servant.API

type UsersAPI = "users" :> QueryParam "sortby" SortBy :> Get '[JSON] [User]

data SortBy = Age | Name

data User = User
  { name :: String
  , age :: Int
  , email :: String
  , registration_date :: UTCTime
  }

type UserAPI = "users" :> QueryParam "name" String :> Get '[JSON] User

type UserAPI2 = "users" :> Capture "userid" Integer :> Get '[JSON] User
