# Introduction to Functional Programming with Haskell

This repository serves as a structured introduction to the concepts of Functional Programming (FP), using the **Haskell** language as the primary vehicle for learning.

It contains lecture notes, code examples, exercises, and projects designed to help learners grasp key functional paradigms like immutability, pure functions, recursion, and higher-order functions.

## Table of Contents

* [Overview](#-introduction-to-functional-programming-with-haskell)
* [Repository Structure](#repository-structure)
* [Getting Started](#getting-started)
* [Contributing](#contributing)
* [License](#license)

## Repository Structure

The content is organized into weekly modules, making it suitable for a course or self-study curriculum. Each folder corresponds to a specific week's material and contains theoretical explanations, practical code demonstrations (`.hs` files), and exercises.

| Folder | Description |
| :--- | :--- |
| `Week 01 - Introduction to Haskell` | Covers the absolute fundamentals of Haskell, including basic syntax, data types, and functions. |
| `LICENSE` | The MIT License for this project. |
| ... | *More weekly modules will be added here as the course progresses.* |

## Getting Started

To work with the Haskell code in this repository, you will need the appropriate compiler and development environment.

### Prerequisites

* **GHC (Glasgow Haskell Compiler):** The standard compiler for Haskell.
* **Stack or Cabal:** Recommended tools for package and build management.

The recommended way to install all necessary tools is via the [Haskell Platform](https://www.haskell.org/downloads/).

### Running the Code

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/vmarkos-mc/functional-programming.git](https://github.com/vmarkos-mc/functional-programming.git)
    cd functional-programming
    ```

2.  **Load files into GHCi (Interactive Environment):**
    You can interactively test functions and definitions by loading a specific file into the GHC Interactive environment:
    ```bash
    ghci Week\ 01\ -\ Introduction\ to\ Haskell/MyFile.hs 
    ```
    (Note: Replace `MyFile.hs` with the actual Haskell file name.)

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/vmarkos-mc/functional-programming/issues) if you have suggestions for new content or find any errors.

1.  **Fork** the repository.
2.  **Create** your feature branch (`git checkout -b feature/AmazingFeature`).
3.  **Commit** your changes (`git commit -m 'Add some AmazingFeature'`).
4.  **Push** to the branch (`git push origin feature/AmazingFeature`).
5.  **Open a Pull Request**.

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
