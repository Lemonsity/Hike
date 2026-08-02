{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Network.HTTP.Types.Status
import Network.Wai
import Network.Wai.Handler.Warp

import           Database.Persist.Sqlite
import           Control.Monad.Logger

import Model
import Handlers.Location

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
sqliteConnInfo = mkSqliteConnectionInfo "data.db"

type WarpLogFunc = (Request -> Status -> Maybe Integer -> IO ())

monadLoggerToWarpLogger :: LogFunc -> WarpLogFunc
monadLoggerToWarpLogger loggerFunc request status fileSize =
  let logSource = "warp server"
      logStr = toLogStr (show request)
        <> toLogStr (show status)
        <> toLogStr ("File size: " <> show fileSize)
  in loggerFunc defaultLoc logSource LevelInfo logStr

warpSetting :: LogFunc -> Settings
warpSetting logFunc =
  setLogger (monadLoggerToWarpLogger logFunc) $
  setPort 8081 defaultSettings

-- warpWebServer :: ConnectionPool -> LogFunc -> IO ()
-- warpWebServer pool logFunc = runSettings (warpSetting logFunc) $ locationsApp pool

warpWebServer :: ConnectionPool -> LoggingT IO ()
warpWebServer pool = LoggingT $
  \logFunc -> runSettings (warpSetting logFunc) $ locationsApp pool

main :: IO ()
main = do
  runSqliteInfo sqliteConnInfo $ do { runMigration migrateAll
                                    ; return () }
  runStderrLoggingT $
    withSqlitePoolInfo (mkSqliteConnectionInfo "data.db") 10 $
    warpWebServer
