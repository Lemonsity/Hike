{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module Handlers.Users
  ( usersApp
  ) where

import Prelude ()
import Prelude.Compat

import Data.Time.Calendar

import Network.Wai
import Servant


import Routes.Users

users :: [User]
users =
  [ User "Isaac Newton"    372 "isaac@newton.co.uk" (fromGregorian 1683  3 1)
  , User "Albert Einstein" 136 "ae@mc2.org"         (fromGregorian 1905 12 1)
  ]

serverUsers :: Server AllUsers
serverUsers = return users

usersAPI :: Proxy AllUsers
usersAPI = Proxy

usersApp :: Application
usersApp = serve usersAPI serverUsers

type MyAPI = Get '[JSON] Int

serverMy :: Server MyAPI
serverMy = return 42

myAPI :: Proxy MyAPI
myAPI = Proxy

myApp :: Application
myApp = serve myAPI serverMy
