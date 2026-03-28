main :: IO()
main = do 
  putStrLn "Simplest Calculator"
  putStrLn "Enter expression (example: 3 + 5) allowed operators +, -, * and / "

  input <- getLine 
  let parts = words input 

  case parts of 
    [a,op,b] -> calculate (read a) op (read b)
    _ -> putStrLn "Invalid format"

-- Parsing calculate function 

calculate :: Int -> String -> Int -> IO()
calculate x "+" y = print (x + y)
calculate x "-" y = print (x - y)
calculate x "*" y = print (x * y)
calculate x "/" y = print (x `div` y)
calculate _ _ _ = putStrLn "Operator Unknown"
