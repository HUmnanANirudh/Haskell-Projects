import System.Environment
import System.Directory (doesFileExist)

fileName :: String
fileName = "tasks.txt"

main :: IO()
main = do 
  createFile
  args <- getArgs

  case args of 
    ["add",task]     -> addTask task
    ["list"]         -> listTasks
    ["complete",num] -> completeTask (read num)
    ["delete",num]   -> deleteTask (read num)
    ["deleteall"]    -> deleteAll
    _ -> putStrLn "All the comands : add <task> | list | delete <index> | deleteall | complete <index>"

-- All the helper function used above

-- Create File

createFile :: IO()
createFile = do 
  exists <- doesFileExist fileName
  if not exists 
    then writeFile fileName ""
    else return ()

-- Add a task

addTask :: String -> IO()
addTask task = do 
  appendFile fileName (task ++ " - pending\n")
  putStrLn "task added"

-- List all tasks  

listTasks :: IO ()
listTasks = do
  content <- readFile fileName
  if null content
    then putStrLn "No Todos added yet"
    else do
      let tasks = lines content
      printTasks tasks 0


-- Print tasks from file

printTasks :: [String] -> Int -> IO ()
printTasks [] _ = return ()
printTasks (t:ts) n = do
  putStrLn (formatTask n t)
  printTasks ts (n + 1)

-- Format task for printing

formatTask :: Int -> String -> String
formatTask i task = show i ++ " - " ++ task

--Read task form File 

getTasks :: IO [String]
getTasks = do 
  content <- readFile fileName
  let tasks = lines content
  length tasks `seq` return tasks

-- Write tasks to file
writeTasks :: [String] -> IO ()
writeTasks tasks = writeFile fileName (unlines tasks)

-- Mark task as completed

completeTask :: Int -> IO ()
completeTask n = do
    tasks <- getTasks
    let updated = take n tasks ++ [markDone (tasks !! n)] ++ drop (n+1) tasks
    writeTasks updated
    putStrLn "Task completed"

-- Change task status to done

markDone :: String -> String
markDone task = takeWhile (/='-') task ++ "- done"

-- Delete one task

deleteTask :: Int -> IO ()
deleteTask n = do
    tasks <- getTasks
    let newTasks = take n tasks ++ drop (n+1) tasks
    writeTasks newTasks
    putStrLn "Task deleted"

-- Delete all tasks

deleteAll :: IO ()
deleteAll = do
    writeFile fileName ""
    putStrLn "All tasks deleted"
