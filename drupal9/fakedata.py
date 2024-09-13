import csv
import random
from faker import Faker
from datetime import datetime, timedelta

# Initialize Faker
fake = Faker('en_US')



def generate_acronym(word_count=3):
    words = [fake.word() for _ in range(word_count)]  # Generate random words

     # Take the first letter of each word
    if word_count > 4:
        words[random.randint(2,4)] = '-'

    acronym = ''.join([word[0].upper() for word in words])

    return acronym

def generate_mission_areas():
    num_mission_areas = 12
    mission_areas = []
    for i in range(num_mission_areas):
        mission_areas.append(generate_acronym(random.randint(3, 8)))
    return mission_areas

staff = [ f'{fake.first_name()} {fake.last_name()}' for _ in range(8)]
statuses = ['Closed']*8 + ['Open']
mission_areas = generate_mission_areas()
inquiry_types = ['General', 'Requirements', 'Technology']
classifications = ['unclassy', 'classy', 'super']
tenets = ['access', 'clear', 'detect', 'detect/neuter', 'dent', 'neuter']
domains = ['air', 'land', 'subt', 'sea']
config = ['None', 'robot', 'walk', 'ride', 'tele', 'other']

land_sub = ['None', 'deep', 'man', 'robot', 'shallow', 'surface', 'stationary']
sea_sub = ['None', 'beach', 'deepwater', 'shallow', 'surfboard', 'verydeep' 'veryshallow']
Acq_status = ['active', 'trans', 'canceled', 'inactive', 'poor']
trl_status = [i+1 for i in range(7)]
ba_status = [i+1 for i in range(7)]
progstatuses = ['active', 'inactive', 'trans', 'canceled']

sources = ['govt', 'industry', 'academia', 'international']
fed_agencies = ['DoD', 'DHS', 'DoE', 'DoT', 'NASA', 'NSA']
army_sources = ['ACOM' 'BCOM', 'CCOM', 'DCOM']
navy_sources = ['ECOM', 'DCOM', 'FCOM', 'GCOM']
OSD_sources = ['HCOM', 'ICOM', 'JCOM']
orgtypes = ['armie', 'navie', 'aire', 'beach', 'cont', 'non-profit', 'academic']

# Function to generate random date across different years
def generate_random_date(not_before=datetime(1960, 1, 1),
                         not_after=datetime.now().year-1):

    random_date = fake.date_between(start_date=not_before, end_date=datetime.now())
    return random_date

def generate_random_date_span(not_before=datetime(1960, 1, 1)):

    random_elapsed_weeks = timedelta(weeks=random.randint(52, 8*52))
    start_date = fake.date_between(start_date=not_before,
                              end_date=datetime.now()-random_elapsed_weeks)
    end_date = start_date + random_elapsed_weeks

    return start_date, end_date


def generate_technologies(num_rows):
    data = [['classification', 'tenet', 'project', 'primarysource', 'domain', 'start', 'stop', 'progstatus']]

    for _ in range(num_rows):
        classification = random.choice(classifications)
        tenet = random.choice(tenets)
        project = f"{fake.catch_phrase()} {fake.bs()}"
        primarysource = random.choice(sources)
        domain = random.choice(domains)
        start, stop = generate_random_date_span()
        progstatus = random.choice(progstatuses)

        data.append([classification, tenet, project, primarysource, domain, start, stop, progstatus])
    save_to_csv(data, 'fake_tech.csv')

def generate_phonebook(num_rows):
    data = [['firstname', 'lastname', 'title', 'organization', 'phone', 'fax', 'email', 'sipremail', 'address', 'city', 'state', 'zip', 'orgtype', 'mission_area'

]]
    for _ in range(num_rows):
        firstname = fake.first_name()
        lastname = fake.last_name()
        title = fake.job()
        organization = fake.company()
        phone = fake.numerify("(###) ###-####")
        if random.randint(1,9) < 3:
            fax = fake.numerify("(###) ###-####")
        else:
            fax = ''

        dns = fake.domain_name()
        email = f'{firstname}.{lastname}@{dns}'
        if random.randint(1,9) < 3:
            sipremail = f'{firstname}.{lastname}@{dns}.smil.mil'
        else:
            sipremail = ''

        street = f'{fake.building_number()} {fake.street_name()}'
        city = fake.city()                      # City name
        state = fake.state()                    # State
        zip_code = fake.postcode()
        orgtype = random.choice(orgtypes)
        mission_area = random.choice(mission_areas)

        data.append([firstname, lastname, title, organization, phone, fax, email, sipremail, street, city, state, zip_code, orgtype, mission_area])
    save_to_csv(data, 'fake_phones.csv')



def generate_rfi(num_rows):
    data = [['firstname', 'lastname', 'title', 'mission_area', 'assigned_to', 'organization', 'question', 'daterecieved', 'status', 'start', 'finish', 'inquiry_type']]

    for _ in range(num_rows):
        # requester
        firstname = fake.first_name()
        lastname = fake.last_name()
        title = fake.job()

        mission_area = random.choice(mission_areas)

        assigned_to = random.choice(staff)

        organization = fake.company()

        question = fake.sentence()
        daterecieved = generate_random_date()
        status = random.choice(statuses)

        start, finish = generate_random_date_span()
        inquiry_type = random.choice(inquiry_types)
        data.append([firstname, lastname, title, mission_area, assigned_to, organization, question, daterecieved, status, start, finish, inquiry_type])

    save_to_csv(data, 'fake_rfi.csv')




# Function to generate fake data
def generate_fake_data(num_rows):
    data = []

    for _ in range(num_rows):
        firstname = fake.first_name()
        lastname = fake.last_name()
        title = fake.job()
        question = fake.sentence()
        daterecieved = fake.date_this_year()
        cost = round(random.uniform(10.0, 1000.0), 2)  # Random cost between 10 and 1000
        temp = random.choice(['low', 'med', 'hi'])  # Random selection for temp
        start_year = random.randint(1961, datetime.now().year)  # Start year after 1960
        end_year = start_year + random.randint(1, 8)  # End year 1 to 8 years after start year
        organization = fake.company()

        data.append([firstname, lastname, title, organizaton, question, daterecieved, cost, temp, start_year, end_year])

    return data

# Function to save data to CSV file
def save_to_csv(data, filename):

    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(data)


# Main function
if __name__ == "__main__":
    num_rows = 100  # Define how many rows of data you want to generate
    generate_technologies(num_rows)
    generate_rfi(num_rows*2)
    generate_phonebook(64)
