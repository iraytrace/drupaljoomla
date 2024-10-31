import random
from faker import Faker
from rand_date import *
from save_csv import save_to_csv
import csv


# Initialize Faker
fake = Faker('en_US')


# surrogate for technology
def generate_saints(num_rows):
    st_classifications = ['public', 'curated', 'private']
    st_tenets = ['relic', 'artifact', 'design']
    st_primary_sources = ['govt', 'denominational', 'academia', 'personal']
    st_domains = ['archangels', 'biblical', 'other']
    st_statuses = ['A', 'B']
    # data = [['classification', 'tenet', 'project', 'primarysource', 'domain', 'start', 'stop', 'progstatus']]
    header = ['title', 'class', 'category', 'description', 'source', 'domain', 'status', 'birth', 'death']
    data = [header]

    with open('saints_by_country.csv', 'r') as fd:
        count = 10
        reader = csv.reader(fd)
        first = True
        for saint,country in reader:
            if first:
                first = False
                continue

            count -= 1
            if count <= 0:
                break;

            classification = random.choice(st_classifications)
            tenet = random.choice(st_tenets)
            description = f"{saint} ({country}) {fake.sentence()}"
            primary_source = random.choice(st_primary_sources)
            if country in st_domains:
                domain = country # really the domain
            else:
                domain = 'regional'
            start, stop = generate_random_date_span(fake, not_before=datetime(10, 1, 1), max_weeks=52*50)
            status = random.choice(st_statuses)

            row = [saint, classification, tenet, description, primary_source, domain, status, start, stop]
            assert ( len(header) == len(row))
            data.append(row)


    save_to_csv(data, 'fake_saints.csv')


# Main function
if __name__ == "__main__":
    generate_saints(120)
