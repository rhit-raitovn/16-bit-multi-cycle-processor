# opcode mapping
OPCODES = {
    # 3R Type: Instructions with opcode 000 
    'add': '000',
    'sub': '000',
    'and': '000',
    'or': '000',
    'xor': '000',
    'sll': '000',
    'srl': '000',
    'sla': '000',
    'sra': '000',

    # 2RI Type: Instructions with opcode 001
    'addi': '001',
    'subi': '001',
    'andi': '001',
    'ori': '001',
    'xori': '001',
    'slli': '001',
    'srli': '001',
    'slai': '001',
    'srai': '001',
    'lw': '001',
    'sw': '001',
    'jalr': '001',
    'beq': '001',
    'blt': '001',
    'bne': '001',
    'bge': '001',

    
    # RI Type: Instructions with opcode 010
    'inc': '010',
    'dec': '010',
    'andd': '010',
    'orr': '010',
    'xorr': '010',
    'slipl': '010',
    'sripl': '010',
    'slipa': '010',
    'sripa': '010',
    'set': '010',

    
    # L Type: Instructions with opcode 011
    'lui': '011',

    # UJ Type: Instructions with opcode 100
    'jal': '100',
}

