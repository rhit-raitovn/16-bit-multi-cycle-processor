def parse_3r_instruction(instruction):
    # splits instruction into tokens
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extracting fields
    opcode = int(tokens[3][0:3], 2)  # Extract opcode from binary string
    func4 = int(tokens[3][3:7], 2)   # Extract func 4 from binary string
    r2 = int(tokens[2][7:10], 2) # Extract r2 from binary string
    r1 = int(tokens[2][10:13], 2) # Extract r1 from binary string
    rd = int(tokens[2][13:], 2) # Extract rd from binary string

    return instruction_type, name, opcode, func4, rd, r1, r2


def parse_l_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    opcode = int(tokens[3][0:3], 2)  # Extract opcode from binary string
    immediate = int(tokens[3][3:], 2)  # Extract immediate value from binary string

    return instruction_type, name, opcode, immediate


def parse_2ri_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    opcode = int(tokens[3][0:3], 2)  # Extract opcode from binary string
    func4 = int(tokens[3][3:7], 2)   # Extract func 4 from binary string
    immediate = int(tokens[2][7:10], 2) # Extract immediate from binary string
    r1 = int(tokens[2][10:13], 2) # Extract r1 from binary string
    rd = int(tokens[2][13:], 2) # Extract rd from binary string

    return instruction_type, name, opcode, func4, immediate, r1, rd


def parse_uj_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    opcode = int(tokens[3][0:3], 2)  # Extract opcode from binary string
    immediate = int(tokens[3][3:13], 2)  # Extract immediate value from binary string
    rd = int(tokens[2][13:], 2) # Extract rd from binary string

    return instruction_type, name, opcode, immediate, rd


def parse_ri_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    opcode = int(tokens[3][0:3], 2)  # Extract opcode from binary string
    func4 = int(tokens[3][3:7], 2)   # Extract func 4 from binary string
    immediate = int(tokens[2][7:13], 2) # Extract immediate from binary string
    rd = int(tokens[2][13:], 2) # Extract rd from binary string

    return instruction_type, name, opcode, func4, immediate, rd

