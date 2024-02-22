def resolve_labels(assembly_code):
    symbol_table = {}
    resolved_code = []

    # First pass: Builds symbol table
    current_address = 0
    for line in assembly_code:
        if line.startswith("//") or "%" in line:
            continue

        tokens = line.strip().split()
        if tokens:
            if tokens[0][-1] == ':':
                label = tokens[0][:-1]
                symbol_table[label] = current_address
            else:
                current_address += 1

    # Second pass: Resolve labels
    for line in assembly_code:
        if line.startswith("//") or "%" in line:
            resolved_code.append(line)
            continue

        tokens = line.strip().split()
        if tokens:
            if tokens[0][-1] == ':':
                resolved_code.append(line)
            else:
                for i in range(len(tokens)):
                    operand = tokens[i]
                    if operand in symbol_table:
                        tokens[i] = str(symbol_table[operand])
                resolved_code.append(" ".join(tokens))

    return resolved_code
