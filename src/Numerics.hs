module Numerics where
{-- A module for various numeric definitions useful in building domain-specific numeric types 
  For each new type, there are various functions defined:

  makeX :: Double -> Maybe X   which creates an X in the input is acceptable
  unsafe_makeX :: Double -> X  make an X which may be invalid. User beware!
  sampleX :: UnitInterval Double -> X   Compute an X from a value in [0,1]. 

  This looks like an opportunity for a new class.

--}

-- | A newtype for aribtrary values in (0,1)
newtype UnitInterval n = UnitInterval n deriving (Show, Eq, Ord)

makeUnitary :: (RealFloat n) => n -> Maybe (UnitInterval n)
makeUnitary x
    | (x < 1) && (x > 0) = Just (UnitInterval x)
    | otherwise          = Nothing

unsafe_makeUnitary :: (RealFloat n) => n -> UnitInterval n
unsafe_makeUnitary x = UnitInterval x


{- A type for Azimuthal Angles limited to -pi < phi < pi.  Generally
intrepted as the angle from positive x, depending on the context.-}
newtype AzimuthAngle = AzimuthAngle Double deriving (Show, Eq, Ord)

makeAzimuthAngle :: Double -> Maybe AzimuthAngle
makeAzimuthAngle x
    | abs x <= pi = Just (AzimuthAngle x) 
    | otherwise   = Nothing
                    
unsafe_makeAzimuthAngle :: Double -> AzimuthAngle
unsafe_makeAzimuthAngle = AzimuthAngle

sampleAzimuthAngle :: UnitInterval Double -> AzimuthAngle
sampleAzimuthAngle (UnitInterval a) = AzimuthAngle (pi*(2*a - 1))


{- A type for Zenith Angles. Limited to 0 < theta < pi. Generally
{ intrepreted as the angle from positive z, depending on context. -}
newtype ZenithAngle = ZenithAngle Double deriving (Show, Eq, Ord)

makeZenithAngle :: Double -> Maybe ZenithAngle
makeZenithAngle z
    | (0 < z) && (z < pi) = Just (ZenithAngle z)
    | otherwise           = Nothing
                            
unsafe_makeZenithAngle :: Double -> ZenithAngle
unsafe_makeZenithAngle = ZenithAngle

sampleZenithAngle :: UnitInterval Double -> ZenithAngle
sampleZenithAngle (UnitInterval a) = ZenithAngle (pi*a)


{- A type for Radii, Limted to 0 < r -}
newtype Radius = Radius Double deriving (Show, Eq, Ord)

makeRadius :: Double -> Maybe Radius
makeRadius x
    | (x > 0)   = Just (Radius x)
    | otherwise = Nothing
                  
unsafe_makeRadius :: Double -> Radius
unsafe_makeRadius = Radius

sampleRadus :: UnitInterval Double -> Radius
sampleRadus (UnitInterval x) = (Radius . negate . log) x