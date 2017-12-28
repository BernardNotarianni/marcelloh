module Cal
    ( Tag (..)
    , parse
    ) where

import Data.List.Split

data Tag = Summary String
         | Month Int
         | Unknown String
  deriving (Show, Eq)

type Event = [ Tag ]

parse :: String -> [ Event ]
parse s =
  events
  where
    (events, []) = collectEvents (splitOn "\n" s) []

collectEvents :: [ String ] -> [ Event ] -> ([ Event ] , [ String ])
collectEvents [] collected = (collected, [])
collectEvents ("BEGIN:VEVENT" : others) collected =
  collectEvents remaining (tags : collected)
  where
    (eventContent, remaining) = collectUntil "END:VEVENT" others []
    tags = map makeTag eventContent
collectEvents (_ : others) collected =
  collectEvents others collected


collectUntil :: String -> [ String ] -> [ String ] -> ( [ String ], [ String ])
collectUntil _ [] collected = (collected, [])
collectUntil end (next : others) collected
  | next == end = (collected, others)
  | otherwise = ( next : c, o)
    where (c,o) = collectUntil end others collected


makeTag :: String -> Tag
makeTag s =
  tag ( splitOn ":" s )
  where
    tag ["SUMMARY" , value] =
      Summary value
    tag ["DSTART;VALUE=DATE" , value] =
      let m = take 2 $ drop 4 value
      in
        Month $ read m
    tag _ =
      Unknown s
