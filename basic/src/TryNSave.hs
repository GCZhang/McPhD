-- TryNSave.hs
-- T. M. Kelley
-- Feb 28, 2011
-- (c) Copyright 2011 LANSLLC, all rights reserved

module TryNSave (writeTally)
    where

import Tally

writeTally :: String -> Tally -> IO ()
writeTally name t = writeFile name $ show t


-- version
-- $Id$

-- End of file
