def resolve_labels(assembly_code):
    symbol_table = {}
    resolved_code = []

    # First pass: Builds symbol table
    current_address = 0
    for line in assembly_code:
        # Skips comments
        if line.startswith("//") or "%" in line:
            continue

        # Splits line into tokens
        tokens = line.strip().split()

        # Checks if line is not empty
        if tokens:
            # Checks if line defines a label
            if tokens[0][-1] == ':':
                label = tokens[0][:-1]  # Remove colon
                symbol_table[label] = current_address
            else:
                current_address += 1

    # Second pass: Resolve labels
    for line in assembly_code:
        # Skips comments
        if line.startswith("//") or "%" in line:
            resolved_code.append(line)
            continue

        # Splits line into tokens
        tokens = line.strip().split()

        # Checks if line is not empty
        if tokens:
            # Checks if line defines a label
            if tokens[0][-1] == ':':
                # Skips label definition lines
                resolved_code.append(line)
            else:
                # Replaces labels in instruction operands with memory addresses
                for i in range(len(tokens)):
                    operand = tokens[i]
                    if operand in symbol_table:
                        tokens[i] = str(symbol_table[operand])
                resolved_code.append(" ".join(tokens))

    return resolved_code

# Euclid's algorithm
assembly_code = [
    "// Find m that is relatively prime to n.",
    "int",
    "relPrime(int n)",
    "{",
    "   int m;",
    "",
    "   m = 2;",
    "",
    "   while (gcd(n, m) != 1) {  // n is the input from the outside world",
    "     m = m + 1;",
    "   }",
    "",
    "   return m;",
    "}",
    "",
    "// The following method determines the Greatest Common Divisor of a and b",
    "// using Euclid's algorithm.",
    "int",
    "gcd(int a, int b)",
    "{",
    "  if (a == 0) {",
    "    return b;",
    "  }",
    "",
    "  while (b != 0) {",
    "    if (a > b) {",
    "      a = a - b;",
    "    } else {",
    "      b = b - a;",
    "    }",
    "  }",
    "",
    "  return a;",
    "}"
]

resolved_code = resolve_labels(assembly_code)

for line in resolved_code:
    print(line)

