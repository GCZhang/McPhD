{-| Datatypes for events generated during simulation.
-}
module Events.Event where

import Space

-- | Vector of particle motion between events
data Motion = Stream Direction deriving Show

-- | What has happened to the particle in the end of a step
data StepEnd = Scatter  -- ^ Particle is changing direction and energy.
             | Boundary -- ^ Particle has encountered a boundary in the domain or mesh.
             deriving Show

-- | What stopped the particle streaming. Type parameter carries final particle value.
data Fate p = Escape p     -- ^ Particle has escaped computational domain
            | Absorption p -- ^ Particle has been absorbed into the material.
            | Survival p   -- ^ Particle remains at end of the computational step.
           deriving Show

data Event p = Event Motion StepEnd    -- ^ Ordinary event consists of a motion and a step end
             | Final (Fate p)          -- ^ Final destination of the particle
             | NullEvent               -- ^ Just for testing
           deriving Show
