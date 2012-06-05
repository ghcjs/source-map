{-# LANGUAGE DeriveGeneric #-}
module Data.SourceMap (
    SourceMap(..)
) where

import Data.Aeson (ToJSON, FromJSON, encode, fromJSON, Result(..))
import GHC.Generics (Generic)
import Data.Attoparsec.Lazy (parse, Result(..), many1)
import Control.Monad (forM_)
import Data.Text (Text)

data SourceMap = SourceMap {
    version   :: Int,
    file      :: FilePath,
    lineCount :: Int,
    mappings  :: Text,
    sources   :: [FilePath],
    names     :: [Text] } deriving (Generic, Eq, Show)

instance FromJSON SourceMap
instance ToJSON SourceMap


