module Main (main) where

import Database.HDBC.Sqlite3

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  _ <- connectSqlite3 "database"
  putStrLn "Hello Again!"
