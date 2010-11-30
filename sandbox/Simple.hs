{-# OPTIONS_GHC -XMultiParamTypeClasses #-}

module Simple where

import Classes

-- A Simple particle.

data Simple = Simple { s_p :: Position,  s_d :: Direction } deriving Show
instance InSpace Simple where
  position   = s_p
  direction  = s_d
  
instance Advance Simple Double where
  advance particle distance =  Simple (move particle distance) (direction particle)

