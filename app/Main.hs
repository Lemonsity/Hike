{-# LANGUAGE OverloadedStrings          #-}

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

-- main :: IO ()
-- main = run 8081 usersApp

runSqlite' :: (MonadUnliftIO m) => Text -> ReaderT SqlBackend (NoLoggingT (ResourceT m)) a -> m a
runSqlite' = runSqlite

main :: IO ()
main = runSqlite' ":memory:" $ do
    runMigration migrateAll
    michaelId <- insert $ Person "Michael" $ Just 26
    michael <- get michaelId
    liftIO $ print michael
