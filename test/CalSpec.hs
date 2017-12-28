{-# LANGUAGE OverloadedStrings #-}
module CalSpec where

import Test.Hspec
import Cal

spec :: Spec
spec = describe "parse" $ do
  it "slice into events" $ do
    parse cal `shouldBe`
      [[ Unknown "DESC:desc"
       , Summary "second"
       , Month 10
       ]
      ,[ Unknown "DESC:desc"
       , Summary "first"
       , Month 12
       ]]
  where
    cal = "whatever\n\
          \BEGIN:VEVENT\n\
          \DESC:desc\n\
          \SUMMARY:first\n\
          \DSTART;VALUE=DATE:20181201\n\
          \END:VEVENT\n\
          \dontcare\n\
          \BEGIN:VEVENT\n\
          \DESC:desc\n\
          \SUMMARY:second\n\
          \DSTART;VALUE=DATE:20181001\n\
          \END:VEVENT\n\
          \somethingelse"
