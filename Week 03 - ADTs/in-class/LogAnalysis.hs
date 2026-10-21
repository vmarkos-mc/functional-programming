module LogAnalysis where

import Log

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong messages = [s | (LogMessage (Error c) _ s) <- sortedMessages, c >= 50]
    where
        sortedMessages = inOrder $ build messages

-- Just for our testing
-- test :: FilePath -> Int -> IO [LogMessage]
-- test logs n = take n . inOrder . build . parse <$> readFile logs


inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left msg right) = (inOrder left) ++ (msg : (inOrder right))


build :: [LogMessage] -> MessageTree
build []        = Leaf      -- Base case
build (m:ms)    = insert m (build ms)


-- Order in what follows is important, since Haskell
-- pattern matches top-down
insert :: LogMessage -> MessageTree -> MessageTree
-- Edge case: Unknown messages are skipped
insert (Unknown _) t    = t
-- Base case: inserting a message in an empty tree
insert msg Leaf         = Node Leaf msg Leaf
insert msg@(LogMessage _ tsa _) (Node left oldMsg@(LogMessage _ tsb _) right)
    | tsa < tsb = Node (insert msg left) oldMsg right
    | otherwise = Node left oldMsg (insert msg right )
    -- "==" is not expected to occur, however we
    -- just capture it here for completeness


parse :: String -> [LogMessage]
parse logs = [ parseMessage line | line <- lines logs ]


parseMessage :: String -> LogMessage
parseMessage "" = Unknown ""        -- Handle empty message separately for convenience
parseMessage msg 
    | w == "I"  = LogMessage Info firstWord (unwords wws)
    | w == "W"  = LogMessage Warning firstWord (unwords wws)
    | w == "E"  = LogMessage (Error firstWord) (read (head wws) :: Int) (unwords $ tail wws)
    | otherwise = Unknown msg
    where
        (w:ws)      = words msg
        -- The following is lazily evaluated, i.e., only when we reference `firstWord`.
        -- This is why on "Unknown" messages this does not throw a runtime error!
        firstWord   = read (head ws) :: Int
        wws         = tail ws


        