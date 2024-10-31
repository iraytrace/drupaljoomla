from datetime import datetime, timedelta
import random

# Function to generate random date across different years
def generate_random_date(fake, not_before=datetime(1960, 1, 1),
                         not_after=datetime.now().year-1):

    random_date = fake.date_between(start_date=not_before, end_date=datetime.now())
    return random_date

def generate_random_date_span(fake, not_before=datetime(1960, 1, 1),
                              max_weeks=416): # 416 = 8 years * 52 weeks/year

    random_elapsed_weeks = timedelta(weeks=random.randint(52, 8*52))
    start_date = fake.date_between(start_date=not_before,
                              end_date=datetime.now()-random_elapsed_weeks)
    end_date = start_date + random_elapsed_weeks

    return start_date, end_date

def subsequent_date(fake, start_date, weeks=(52,416)):
    random_elapsed_weeks = timedelta(weeks=random.randint(weeks[0], weeks[1]))
    end_date = start_date + random_elapsed_weeks
    return end_date

def date_spans(fake, num_rows):
    starts = [generate_random_date(fake) for _ in range(num_rows)]
    stops = [ subsequent_date(fake, i) for i in starts]
    return starts, stops
