def convert_binary_lines(input_file, output_file):
    """Combines pairs of 16-bit binary lines into 32-bit lines in a new file,
    handling any number of lines (up to 2000)."""

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        lines = infile.readlines()

        # Handle the case where the number of lines is odd
        if len(lines) % 2 != 0:
            lines.append("0000000000000000")  # Add a padding line for the last odd line

        # Process lines in pairs
        for i in range(0, len(lines), 2):
            combined = lines[i + 1].strip() + lines[i].strip()
            outfile.write(combined + "\n")


if __name__ == "__main__":
    input_file = "sine_wave.txt"  # Replace with your actual input file name
    output_file = (
        "sine_wave_nios_final.txt"  # Replace with your desired output file name
    )
    convert_binary_lines(input_file, output_file)
