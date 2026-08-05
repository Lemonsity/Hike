{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Routes.Location
  ( AllLocations
  )
  where

import Servant.API

import Model

type AllLocations = "locations" :> Get '[JSON] [Location]
