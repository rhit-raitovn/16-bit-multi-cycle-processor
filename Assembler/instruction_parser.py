def parse_3r_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extract opcode and funct4 from opcode mappings
    opcode, func4 = OPCODES[name]

    # Extracting fields
    r2 = int(tokens[2][7:10], 2)
    r1 = int(tokens[2][10:13], 2)
    rd = int(tokens[2][13:], 2)

    return instruction_type, name, opcode, func4, rd, r1, r2


def parse_l_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extract opcode and immediate from opcode mappings
    opcode, immediate = OPCODES[name]

    return instruction_type, name, opcode, immediate


def parse_2ri_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extract opcode, func4, immediate, r1, and rd from opcode mappings
    opcode, func4, immediate = OPCODES[name]

    return instruction_type, name, opcode, func4, immediate, int(tokens[2][10:13], 2), int(tokens[2][13:], 2)


def parse_uj_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extract opcode and immediate from opcode mappings
    opcode, immediate = OPCODES[name]

    return instruction_type, name, opcode, immediate, int(tokens[2][13:], 2)


def parse_ri_instruction(instruction):
    tokens = instruction.split()

    instruction_type = tokens[0]
    name = tokens[1]
    
    # Extract opcode, func4, immediate, and rd from opcode mappings
    opcode, func4, immediate = OPCODES[name]

    return instruction_type, name, opcode, func4, immediate, int(tokens[2][13:], 2)
