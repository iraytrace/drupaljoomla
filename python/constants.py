import random
from acronym import acronym

mission_areas = ['TSNH-MUT', 'GLB', 'CFWA', 'ADAH-', 'TCD-T', 'LWT-BRWC', 'GO-LW']
staff = ['William Robertson', 'Amanda Walker', 'Suzanne Gutierrez', 'Brooke Harper', 'Patricia Rivera', 'Timothy Carroll', 'Ross Norris', 'Lauren Mcmillan']
orgtypes = ['green', 'teal', 'blue', 'sand', 'red', 'yellow', 'aqua']

def doit(fake):
    mission_areas = [acronym(fake, random.randint(3,9)) for _ in range(7) ]
    staff = [ f'{fake.first_name()} {fake.last_name()}' for _ in range(8)]
    return mission_areas, staff, orgtypes