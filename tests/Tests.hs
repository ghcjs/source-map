{-# LANGUAGE CPP, TemplateHaskell, RecordWildCards, OverloadedStrings #-}
module Main (
    main
) where

import Control.Monad (unless)
import Control.Applicative ((<$>))
import System.Exit (exitFailure)
import Test.QuickCheck.Arbitrary (Arbitrary(..))
import Test.QuickCheck.All (quickCheckAll)
import Data.SourceMap (SourceMap(..))
import Data.Aeson (encode, decode)
import Data.Text (pack)

instance Arbitrary SourceMap where
    arbitrary = do
        version <- arbitrary
        file <- arbitrary
        lineCount <- arbitrary
        mappings <- pack <$> arbitrary
        sources <- arbitrary
        names <- map pack <$> arbitrary
        return SourceMap{..}
    shrink _ = []

prop_json :: SourceMap -> Bool
prop_json sm = decode (encode sm) == Just sm

main = do
    allPass <- $quickCheckAll
    unless allPass exitFailure
