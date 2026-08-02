module Handlers.Location
  ( locationsApp
  ) where

import Prelude ()
import Prelude.Compat
import Control.Monad.IO.Class
import Control.Monad.Reader
import Routes.Location
import Database.Persist.Sql
import Servant

import Model

serverLocations :: ConnectionPool -> Server AllLocations
serverLocations pool = liftIO $
  let action = do
        locations <- selectList [] []
        return $ map entityVal locations
  in runSqlPool action pool

locationsAPI :: Proxy AllLocations
locationsAPI = Proxy

locationsApp :: ConnectionPool -> Application
locationsApp pool = serve locationsAPI (serverLocations pool)
