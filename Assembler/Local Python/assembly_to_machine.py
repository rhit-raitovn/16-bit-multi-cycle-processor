# Assembly instructions and their machine code representations
instructions = {
    # relPrime function
    0x0000: "0000000000000011",  # lui 0
    0x0002: "0010011000100001",  # subi sp, sp, 4
    0x0004: "0000010001001001",  # sw ra, 0(sp)
    0x0006: "1100010011001001",  # sw a0, 1(sp)
    0x0008: "1110000100110010",  # set a1, 2
    0x000A: "0100000100110010",  # set s0, 1

    # loop
    0x000C: "0000000000000100",  # jal ra, gcd
    0x000E: "1100101001010010",  # beq a0, s0, exit_loop
    0x0010: "0001100011001001",  # lw a0, 1(sp)
    0x0012: "1111110010000001",  # addi a1, a1, 1
    0x0014: "0110000001100010",  # jal t0, loop

    # exit_loop
    0x0016: "1101110000000001",  # addi a0, a1, 0
    0x0018: "0010010001001001",  # lw ra, 0(sp)
    0x001A: "0010011000000001",  # addi sp, sp, 4
    0x001C: "0110000001010001",  # jalr t0, 0(ra)

    # gcd function
    0x001E: "0110000000110010",  # set t0, 0
    0x0020: "1100110111011001",  # bne a0, t0, gcd_loop
    0x0022: "1101110110000000",  # add a0, a1, t0
    0x0024: "0110000001010001",  # jalr t0, 0(ra)

    # gcd_loop
    0x0026: "1110110111011001",  # bne a1, t0, gcd_end
    0x0028: "1101110111101001",  # bge a0, a1, greater
    0x002A: "1111111100001000",  # sub a1, a1, a0
    0x002C: "1100000110110000",  # jal t0, gcd_loop

    # greater
    0x002E: "1101101110001000",  # sub a0, a0, a1
    0x0030: "0110000110110000",  # jal t0, gcd_loop

    # gcd_end
    0x0032: "0110000001010001"   # jalr t0, 0(ra)
}

# Prints the assembly instructions and their machine code representations
for address, instruction in instructions.items():
    print(f"{hex(address)}: {instruction}")
