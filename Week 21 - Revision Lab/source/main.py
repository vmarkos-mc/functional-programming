from Parser import parse, scan_tokens
from os import path

# Alter this to fit your project's structure

def main():
    response = input("Press 'q' to exit or any key to start!")
    while response != "q":
        filepath = input("Enter CSS file path to parse: ")
        with open(filepath) as css_file:
            css_source = css_file.read()
        tokens = scan_tokens(css_source)
        ast = parse(tokens)
        print("AST:")
        print(ast) # You might need a function to stringify your AST