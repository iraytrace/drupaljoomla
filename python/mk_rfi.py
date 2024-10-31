import random
from faker import Faker
from rand_date import *
from save_csv import save_to_csv
from acronym import acronym
import csv
from constants import *

def generate_rfi(fake, num_rows):
    companies = [fake.company().replace(',', '-') for _ in range(20)]
    statuses = ['Closed']*8 + ['Open']
    inquiry_types = ['General', 'Requirements', 'Technology']

    data = [['name', 'position', 'mission_area', 'assigned_to', 'organization', 'question', 'daterecieved', 'status', 'start', 'finish', 'inquiry_type']]

    for _ in range(num_rows):
        # requester
        name = f'{fake.first_name()} {fake.last_name()}'
        position = fake.job().replace(',', ';')

        mission_area = random.choice(mission_areas)

        assigned_to = random.choice(staff)

        organization = random.choice(companies)

        question = fake.sentence()
        daterecieved = generate_random_date(fake)
        status = random.choice(statuses)

        start, finish = generate_random_date_span(fake)
        inquiry_type = random.choice(inquiry_types)
        data.append([name, position, mission_area, assigned_to, organization, question, daterecieved, status, start, finish, inquiry_type])

    save_to_csv(data, 'fake_rfi.csv')


# Main function
if __name__ == "__main__":
    num_rows = 100  # Define how many rows of data you want to generate
    # Initialize Faker
    fake = Faker('en_US')
    generate_rfi(fake, num_rows*2)
