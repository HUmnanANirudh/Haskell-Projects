# Haskell Mini Projects Collection

This repository contains a set of projects written in **Haskell**.
Each project explores a different concept such as **functional programming, parsing, CLI tools, recursion, and simple interpreters**.

The goal of these projects is to understand how core programming concepts work in a **purely functional language**.

These projects helped me build a deeper understanding of functional programming and how languages like Haskell structure programs internally.

---

# Projects Overview


# 1. Mini Expression Interpreter

A small interpreter that parses and evaluates arithmetic expressions.

Supported operations:

```
+  -  *  /
( )
```

Example:

```
(3 + 4) * 5
```

Output:

```
35
```

### Features

* Supports **BODMAS precedence**
* Parentheses support
* Recursive descent parser
* Tokenization of input
* Interactive REPL

### Concepts Used

* Abstract Syntax Trees (AST)
* Recursive parsing
* Tokenization
* Expression evaluation
* Functional recursion
* Interpreter design

### Architecture

Expression parsing is split into three levels:

```
Expression -> + -
Term       -> * /
Factor     -> numbers or parentheses
```

This structure automatically enforces operator precedence.

- - -

# 2. Markov Chain Text Generator

This project generates random sentences using a **Markov Chain text model**.

The program learns patterns from a training text file and generates new sentences based on those patterns.

### Example

Training text:

```
the cat sat on the mat
the cat ate fish
```

Possible output:

```
the cat sat on the mat
```

### Features

* Uses **trigram Markov model**
* Random sentence generation
* Reads training data from a text file
* Uses a dictionary-like structure (`Map`) for word transitions

### Concepts Used

* Functional data structures
* Recursion
* Random number generation
* Maps (`Data.Map`)
* Pattern matching
* File IO

### How It Works

1. The program reads a training text file.
2. It splits the text into words.
3. It creates triples of words `(w1, w2, w3)`.
4. A map is built where:

```
(w1, w2) -> possible next words
```

5. The generator randomly selects a starting pair and builds a sentence.

---

# 3. Todo CLI Application

A command-line **Todo List Manager** built in Haskell.

Users can add tasks, list them, mark them complete, or delete them.

### Commands

Add a task:

```
todo add "learn haskell"
```

List tasks:

```
todo list
```

Complete task:

```
todo complete 1
```

Delete task:

```
todo delete 1
```

Delete all tasks:

```
todo deleteall
```

### Features

* File-based task storage
* Task indexing
* Mark tasks as complete
* Delete individual or all tasks

Tasks are stored inside:

```
tasks.txt
```

Example:

```
learn haskell - pending
write project - done
```

### Concepts Used

* Command line arguments (`System.Environment`)
* File handling
* Recursion
* List processing
* Pattern matching
* State persistence via files

---

## 4. Calculator

A simple command-line calculator that evaluates expressions with two operands.

Example input:

```
3 + 5
```

Example output:

```
8
```

### Features

* Supports basic arithmetic operations:

  * addition (`+`)
  * subtraction (`-`)
  * multiplication (`*`)
  * division (`/`)
* Simple expression parsing using `words`
* Pattern matching for operator handling

### Concepts Used

* Pattern Matching
* Case Expressions
* Basic IO
* String parsing
* Function definitions

### How It Works

The program:

1. Reads input from the user.
2. Splits the expression into parts using `words`.
3. Pattern matches the format `[a, op, b]`.
4. Performs the correct operation using the `calculate` function.

---
