def hex_to_binary(hex_string):
    """Converts a hexadecimal string to a 16-bit binary string."""
    if not hex_string:  # Check if hex_string is empty
        return ""
    binary_string = bin(int(hex_string, 16))[2:].zfill(16)
    return binary_string


def convert_binary_lines(input_file, output_file):
    """Combines pairs of 16-bit binary lines into 32-bit lines in a new file,
    handling any number of lines (up to 2000)."""

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        lines = infile.readlines()

        # Convert hexadecimal lines to binary
        binary_lines = [hex_to_binary(line.strip()) for line in lines]

        # Handle the case where the number of lines is odd
        if len(binary_lines) % 2 != 0:
            binary_lines.append(
                "0000000000000000"
            )  # Add a padding line for the last odd line

        # Process lines in pairs
        for i in range(0, len(binary_lines), 2):
            combined = "0b" + binary_lines[i + 1] + binary_lines[i]
            outfile.write(combined + "\n")


if __name__ == "__main__":
    input_file = "output_data.txt"  # Replace with your actual input file name
    output_file = "output_data_pair.txt"  # Replace with your desired output file name
    convert_binary_lines(input_file, output_file)
