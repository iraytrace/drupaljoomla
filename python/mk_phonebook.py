import random
from faker import Faker
from rand_date import *
from save_csv import save_to_csv
from acronym import acronym
import csv
from constants import *

def generate_phonebook(fake, num_rows):
    data = [['firstname', 'lastname', 'position', 'organization', 'phone', 'fax', 'email', 'personalemail', 'address', 'city', 'state', 'zip', 'orgtype', 'mission_area'

]]

    for _ in range(num_rows):
        firstname = fake.first_name()
        lastname = fake.last_name()
        position = fake.job()
        organization = fake.company()
        phone = fake.numerify("(###) ###-####")
        if random.randint(1,9) < 3:
            fax = fake.numerify("(###) ###-####")
        else:
            fax = ''

        dns = fake.domain_name()
        email = f'{firstname}.{lastname}@{dns}'
        if random.randint(1,9) < 3:
            personalemail = f'{firstname}.{lastname}@{dns}.smil.mil'
        else:
            personalemail = ''

        street = f'{fake.building_number()} {fake.street_name()}'
        city = fake.city()                      # City name
        state = fake.state()                    # State
        zip_code = fake.postcode()
        orgtype = random.choice(orgtypes)
        mission_area = random.choice(mission_areas)

        data.append([firstname, lastname, position, organization, phone, fax, email, personalemail, street, city, state, zip_code, orgtype, mission_area])
    save_to_csv(data, 'fake_phones.csv')

# Main function
if __name__ == "__main__":
    num_rows = 100  # Define how many rows of data you want to generate
    # Initialize Faker
    fake = Faker('en_US')

    generate_phonebook(fake, num_rows*2)
