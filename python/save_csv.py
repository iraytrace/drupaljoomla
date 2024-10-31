import csv

# Function to save data to CSV file
def save_to_csv(data, filename):

    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file ) # , delimiter='+') # quoting=csv.QUOTE_ALL, quotechar='"')
        writer.writerows(data)