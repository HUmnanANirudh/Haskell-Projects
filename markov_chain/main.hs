import System.Random
import qualified Data.Map as Map 
import Data.List

type Key = (String, String)
type Markov = Map.Map Key [String]

main :: IO()
main = do 
  putStrLn "Reading training text..."
  
  content <- readFile "text.txt"
  let ws = words content

  let model = buildModel ws 

  sentence <- generateSentence model 15

  putStrLn "\nGenerated sentence:"
  putStrLn sentence

-- Trigram model 

buildModel :: [String] -> Markov
buildModel ws =
  Map.fromListWith (++)
    [((w1,w2),[w3])
    |(w1,w2,w3) <- triples ws 
    ]

-- converting list into triples

triples::[String]->[(String,String,String)]
triples (a:b:c:rest) = (a,b,c) : triples (b:c:rest)
triples _ = []

-- generating sentence 

generateSentence :: Markov -> Int -> IO String
generateSentence model n = do 
  let keys = Map.keys model

  startIndex <- randomRIO (0, length keys - 1)
  let (w1,w2) = keys !! startIndex

  generate model w1 w2 n 

generate :: Markov -> String -> String -> Int -> IO String
generate model w1 w2 n = do 
  let nextWords = Map.findWithDefault [] (w1,w2) model

  if null nextWords 
      then return (w1 ++ " " ++ w2)
      else do 
        i <- randomRIO (0,length nextWords -1)
        let nextWord = nextWords !! i 

        rest <- generate model w2 nextWord (n-1)

        return (w1 ++ " " ++ rest)

