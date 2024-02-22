def write_machine_code_to_file(machine_code, output_file):
    with open(output_file, 'w') as f:
        for line in machine_code:
            f.write(line + '\n')


def main():
    # Read assembly code input from the user
    print("Enter your assembly code (press Enter twice to finish):")
    assembly_code = []
    while True:
        line = input()
        if line.strip() == "":
            break
        assembly_code.append(line)

    # Resolve labels in assembly code
    resolved_code = resolve_labels(assembly_code)

    # Parse instructions in assembly code
    parsed_instructions = [parse_3r_instruction(instruction) for instruction in resolved_code]

    # Generate machine code from parsed instructions
    machine_code = generate_machine_code(parsed_instructions)

    # Output the assembled code to the user
    print("Assembled code:")
    for line in machine_code:
        print(line)

    # Optionally, write the machine code to a file
    output_file = input("Enter the filename to save the assembled code (press Enter to skip): ")
    if output_file.strip():
        write_machine_code_to_file(machine_code, output_file)
        print(f"Machine code saved to {output_file}")


if __name__ == "__main__":
    main()
