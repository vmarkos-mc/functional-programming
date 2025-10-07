# in-class/immutability.py

class C:
    def __init__(self, x: int) -> None:
        self.x = x

    def __str__(self) -> str:
        """ This is a side effect, since `__str__` modified an object-field that is (mostly)
        irrelevant to the functionality of `__str__`. """
        
        self.x += 1 
        return f"C Object: x == {self.x}"
    
if __name__ == "__main__":
    c = C(5)
    print(c)
    print(c)
    print(c)