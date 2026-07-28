module Main (main) where

import Network.Wai.Handler.Warp

import Handlers.Users

main :: IO ()
main = run 8081 usersApp
