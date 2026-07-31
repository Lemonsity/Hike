{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Network.Wai.Handler.Warp

import Handlers.Users

import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH
import           Data.Text
import           Control.Monad.Reader
import           Control.Monad.Logger
import           Conduit

import Model
import Handlers.Location

-- | Default SQLite connection info
-- See documentation for detail
sqliteConnectionInfo :: SqliteConnectionInfo
sqliteConnectionInfo = mkSqliteConnectionInfo "data.db"

-- main :: IO ()
-- main = run 8081 usersApp

-- runSqlite' :: (MonadUnliftIO m) => SqliteConnectionInfo -> ReaderT SqlBackend (NoLoggingT (ResourceT m)) a -> m a
-- runSqlite' = runSqliteInfo

-- main :: IO ()
-- main = runSqliteInfo sqliteConnectionInfo $ do
--     runMigration migrateAll
--     michaelId <- insert $ Location 1.0 2.0
--     michael <- get michaelId
--     liftIO $ print michael


main :: IO ()
main = runStderrLoggingT $
       withSqlitePoolInfo sqliteConnectionInfo 10 $
       (\pool -> LoggingT { runLoggingT = const $ run 8081 $ locationsApp pool })
