{-# LANGUAGE BangPatterns #-}

module RandomValues where

import SpaceTime.Space3DCartesian

import System.Random.Mersenne.Pure64
import Data.Vector.V3
import Vectors

-- import Data.Vector.V3
import Data.List (unfoldr)

newtype Seed = Seed { toInt :: Integer }
makePureMT :: Seed -> PureMT
makePureMT = pureMT . fromIntegral . toInt

normalizedVector3_compute :: Double -> Double -> Vector3
normalizedVector3_compute a b = let
  theta = a * pi
  phi   = b * 2*pi
  in sphericalToNormalVector3 phi theta

-- | Compute a random direction vector from a two random doubles
randomDirection_compute :: Double -> Double -> Direction
randomDirection_compute a b = direction $ normalizedVector3_compute a b

-- | Compute a random Direction from a PureMT
randomDirection :: PureMT -> (Direction, PureMT)
randomDirection g = let
  (a, g')  = randomDouble g
  (b, g'') = randomDouble g'
  in (randomDirection_compute a b, g'')

-- | Sample an exponential distribution from a random double
randomExponential_compute :: Double -> Double -> Double
randomExponential_compute lambda a = -log (a)*lambda

-- | Sample an exponential Distance from a PureMT
randomExponential :: Double -> PureMT -> (Distance, PureMT)
randomExponential lambda g = let
  (a, g') = randomDouble g
  in (Distance $ randomExponential_compute lambda a, g')


-- | Get N samples from the given random function and PureMT
sampleN :: (PureMT -> (a, PureMT)) -> PureMT -> Int -> [a]
sampleN generator rand n
  | n <= 0 = []
  | otherwise =
    let (value, rand') = generator rand
    in value : ( sampleN generator rand' (n-1) )

samples :: (PureMT -> (a, PureMT)) -> PureMT -> [a]
samples generator rand = unfoldr (Just . generator) rand
