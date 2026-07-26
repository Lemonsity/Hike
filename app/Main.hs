module Main (main) where

import Control.Applicative ((<$>), optional)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Happstack.Lite
import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label)
import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Database.HDBC.Sqlite3


main :: IO ()
main = serve Nothing myApp

myApp :: ServerPart Response
myApp = msum
  [ dir "echo"    $ echo
  , dir "query"   $ queryParams
  , dir "form"    $ formPage
  , dir "fortune" $ fortune
  , dir "files"   $ fileServing
  , dir "upload"  $ upload
  , homePage
  ]


-- main :: IO ()
-- main = do
--   putStrLn "Hello, Haskell!"
--   _ <- connectSqlite3 "database"
--   putStrLn "Hello Again!"
