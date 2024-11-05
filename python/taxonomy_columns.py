import pandas as pd
import sys

# Check if the input file name is provided
if len(sys.argv) != 2:
    print("Usage: python script.py <input_file.tsv>")
    sys.exit(1)

# Get the input file name from the command line
input_file = sys.argv[1]

# Read the TSV file (tab-separated)
df = pd.read_csv(input_file, delimiter='\t')

# Iterate over each column and check if it contains only 0/1 values
for column in df.columns:
    if df[column].isin([0, 1]).all():  # Check if the column only contains 0s and 1s
        df[column] = df[column].apply(lambda x: column if x == 1 else "")

# Save the modified DataFrame to a new TSV file
output_file = 'output.tsv'
df.to_csv(output_file, sep='\t', index=False)

print(f"TSV file has been modified and saved as '{output_file}'")
