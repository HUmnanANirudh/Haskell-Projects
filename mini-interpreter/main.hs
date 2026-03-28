import Data.Char

data Expr 
  = Num Int 
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr

-- Expression 

eval :: Expr -> Int
eval (Num n) = n 
eval (Add a b) = eval a + eval b 
eval (Sub a b) = eval a - eval b 
eval (Mul a b) = eval a * eval b 
eval (Div a b) = eval a `div` eval b 

-- Parsering Expression

parseExpr :: [String] -> (Expr,[String])
parseExpr tokens =
    let (term, rest) = parseTerm tokens
    in parseExprRest term rest

parseExprRest :: Expr -> [String] -> (Expr,[String])
parseExprRest left ("+":xs) =
    let (right,rest) = parseTerm xs
    in parseExprRest (Add left right) rest

parseExprRest left ("-":xs) =
    let (right,rest) = parseTerm xs
    in parseExprRest (Sub left right) rest

parseExprRest left xs = (left,xs)

-- Parsering Term 

parseTerm :: [String] -> (Expr,[String])
parseTerm tokens =
    let (factor,rest) = parseFactor tokens
    in parseTermRest factor rest

parseTermRest :: Expr -> [String] -> (Expr,[String])
parseTermRest left ("*":xs) =
    let (right,rest) = parseFactor xs
    in parseTermRest (Mul left right) rest

parseTermRest left ("/":xs) =
    let (right,rest) = parseFactor xs
    in parseTermRest (Div left right) rest

parseTermRest left xs = (left,xs)

-- Numbers or parentheses

parseFactor :: [String] -> (Expr,[String])

parseFactor ("(":xs) =
    let (expr,rest) = parseExpr xs
    in case rest of
        (")":rest2) -> (expr,rest2)
        _ -> error "Missing )"

parseFactor (n:xs) = (Num (read n), xs)

parseFactor [] = error "Invalid input"

-- TOKENIZER

tokenize :: String -> [String]
tokenize [] = []

tokenize (c:cs)
    | isSpace c = tokenize cs
    | c `elem` "+-*/()" = [c] : tokenize cs
    | isDigit c =
        let (num,rest) = span isDigit (c:cs)
        in num : tokenize rest
    | otherwise = tokenize cs

-- REPL

repl :: IO ()
repl = do
    putStr "> "
    input <- getLine

    if input == "exit"
        then putStrLn "Goodbye!"
        else do
            let tokens = tokenize input
            let (expr,_) = parseExpr tokens
            print (eval expr)
            repl

main :: IO ()
main = do
    putStrLn "Mini Calculator"
    putStrLn "Supports: + - * / and parentheses"
    putStrLn "Example: (3 + 4) * 5 / 2"
    putStrLn "Type exit to quit"
    repl
