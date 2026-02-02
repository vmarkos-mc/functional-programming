# in-class/gen_004.py

def dummy():
    while True:
        n = yield
        yield n ** 2

if __name__ == "__main__":
    nums = dummy()
    print(next(nums))
    print(nums.send(4))
    print(next(nums))
    print(nums.send(-3))
    print(next(nums))
    nums.close()