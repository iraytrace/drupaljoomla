import random
from faker import Faker

def acronym(fake, word_count=3):
    words = [fake.word() for _ in range(word_count)]  # Generate random words

     # Take the first letter of each word
    if word_count > 4:
        words[random.randint(2,4)] = '-'

    acronym = ''.join([word[0].upper() for word in words])

    return acronym