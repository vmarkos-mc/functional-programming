# source/send.py

def dummy():
    while True:
        n = yield # Fancy way of writing yield x
        yield n ** 2

if __name__ == "__main__":
    nums = dummy()
    print(next(nums)) # What is this for?
    print(nums.send(4)) # And this?
    print(next(nums)) # What about that?
    print(nums.send(-3)) # Or that?
    print(next(nums)) # Or that?