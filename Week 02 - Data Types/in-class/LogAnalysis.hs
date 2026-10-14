module LogAnalysis where

import Log

parseMessage :: String -> LogMessage
parseMessage "" = Unknown ""        -- Handle empty message separately for convenience
parseMessage msg 
    | w == "I"  = ...
    | w == "W"  = ...
    | w == "E"  = ...
    | otherwise = Unknown msg
    where
        (w:ws) = words msg