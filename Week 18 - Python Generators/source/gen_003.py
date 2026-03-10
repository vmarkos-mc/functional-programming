# source/gen_003.py

def nums(start=1):
    i = start
    while True:
        yield i
        i = i + 1

def primes(sieve = []):
    for i in nums(2):
        if all((i % k > 0 for k in sieve)):
            sieve.append(i)
            yield i

if __name__ == "__main__":
    for x in primes():
        # if x > 200:
        #     break
        print(x, end=" ")
    print()