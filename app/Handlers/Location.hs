module Handlers.Location
  ( locationsApp
  ) where

import Prelude ()
import Prelude.Compat
import Control.Monad.IO.Class
import Routes.Location
import Database.Persist.Sql
import Servant

serverLocations :: ConnectionPool -> Server AllLocations
serverLocations pool = liftIO $ runSqlPool _ pool

locationsAPI :: Proxy AllLocations
locationsAPI = Proxy

locationsApp :: ConnectionPool -> Application
locationsApp pool = serve locationsAPI (serverLocations pool)
