{-# LANGUAGE OverloadedStrings #-}
module Main where

import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
  manager <- newManager tlsManagerSettings

  request <- parseRequest ("GET " ++ url)
  response <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus response)
  print $ responseBody response

url :: String
url = "https://calendar.google.com/calendar/ical/bernard.notarianni%40gmail.com/private-809dc29f02232e7b149dd6ce390f135e/basic.ics"
