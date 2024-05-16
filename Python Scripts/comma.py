input_file = "output_data_pair.txt"
output_file = "formatted_data_pair.txt"

with open(input_file, "r") as f_in, open(output_file, "w") as f_out:
    for line in f_in:
        line = line.strip()
        if line:
            # formatted_line = "0b" + line + ","
            formatted_line = line + ","
            f_out.write(formatted_line + "\n")

print("Formatting completed. Output written to", output_file)
