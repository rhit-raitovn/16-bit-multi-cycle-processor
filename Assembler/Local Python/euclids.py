# Find m that is relatively prime to n.
def relPrime(n):
    m = 2
    while gcd(n, m) != 1:  # n is the input from the outside world
        m = m + 1
    return m

# The following method determines the Greatest Common Divisor of a and b using Euclid's algorithm.
def gcd(a, b):
    if a == 0:
        return b
    while b != 0:
        if a > b:
            a = a - b
        else:
            b = b - a
    return a

# Example usage:
n = 10
result = relPrime(n)
print("Result:", result)
