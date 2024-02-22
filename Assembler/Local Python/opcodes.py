# Opcode and funct4 mapping
OPCODES = {
    # 3R Type: Instructions with opcode 000 
    'add': ('000', '0000'),
    'sub': ('000', '0001'),
    'and': ('000', '0010'),
    'or': ('000', '0011'),
    'xor': ('000', '0100'),
    'sll': ('000', '0101'),
    'srl': ('000', '0110'),
    'sla': ('000', '0111'),
    'sra': ('000', '1000'),

    # 2RI Type: Instructions with opcode 001
    'addi': ('001', '0000'),
    'subi': ('001', '0001'),
    'andi': ('001', '0010'),
    'ori': ('001', '0011'),
    'xori': ('001', '0100'),
    'slli': ('001', '0101'),
    'srli': ('001', '0110'),
    'slai': ('001', '0111'),
    'srai': ('001', '1000'),
    'lw': ('001', '1001'),
    'sw': ('001', '1010'),
    'jalr': ('001', '1011'),
    'beq': ('001', '1100'),
    'blt': ('001', '1101'),
    'bne': ('001', '1110'),
    'bge': ('001', '1111'),

    
    # RI Type: Instructions with opcode 010
    'inc': ('010', '0000'),
    'dec': ('010', '0001'),
    'andd': ('010', '0010'),
    'orr': ('010', '0011'),
    'xorr': ('010', '0100'),
    'slipl': ('010', '0101'),
    'sripl': ('010', '0110'),
    'slipa': ('010', '0111'),
    'sripa': ('010', '1000'),
    'set': ('010', '1100'),

    
    # L Type: Instructions with opcode 011
    'lui': ('011', ''), #no funct4

    # UJ Type: Instructions with opcode 100
    'jal': ('100', ''), #no funct4
}
