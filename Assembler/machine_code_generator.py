from opcodes import OPCODES

def generate_machine_code(parsed_instructions):
    machine_code = []

    for instruction_type, instruction in parsed_instructions:
        if instruction_type == '3R':
            opcode, func4, rd, r1, r2 = instruction
            machine_code.append(f"{OPCODES[instruction[1]]} {func4:04b} {r2:03b} {r1:03b} {rd:03b}")
        elif instruction_type == 'L':
            opcode, immediate = instruction
            machine_code.append(f"{OPCODES[instruction[1]]} {immediate:010b}")
        elif instruction_type == '2RI':
            opcode, func4, immediate, r1, rd = instruction
            machine_code.append(f"{OPCODES[instruction[1]]} {func4:04b} {immediate:03b} {r1:03b} {rd:03b}")
        elif instruction_type == 'UJ':
            opcode, immediate, rd = instruction
            machine_code.append(f"{OPCODES[instruction[1]]} {immediate:010b} {rd:03b}")
        elif instruction_type == 'RI':
            opcode, func4, immediate, rd = instruction
            machine_code.append(f"{OPCODES[instruction[1]]} {func4:04b} {immediate:06b} {rd:03b}")

    return machine_code

