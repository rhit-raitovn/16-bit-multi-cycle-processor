from instruction_parser import parse_3r_instruction, parse_l_instruction, parse_2ri_instruction, parse_uj_instruction, parse_ri_instruction
from label_reader import resolve_labels
from opcode import OPCODES

def assemble(assembly_code):
    # Resolve labels
    resolved_code = resolve_labels(assembly_code)

    # Parse instructions and generate machine code
    machine_code = []
    for line in resolved_code:
        tokens = line.split()
        if tokens:
            instruction_type = tokens[0]
            if instruction_type == '3R':
                parsed_instruction = parse_3r_instruction(line)
            elif instruction_type == 'L':
                parsed_instruction = parse_l_instruction(line)
            elif instruction_type == '2RI':
                parsed_instruction = parse_2ri_instruction(line)
            elif instruction_type == 'UJ':
                parsed_instruction = parse_uj_instruction(line)
            elif instruction_type == 'RI':
                parsed_instruction = parse_ri_instruction(line)
            opcode, *operands = parsed_instruction
            machine_code.append(f"{OPCODES[opcode]} {' '.join(map(str, operands))}")
    
    return machine_code

# Example usage:
if __name__ == "__main__":
    # Example assembly code
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

    # Assemble the code
    machine_code = assemble(assembly_code)

    # Print machine code
    for line in machine_code:
        print(line)
