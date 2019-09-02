#the env file must be called 'env' (without the quotes) and must be
#in the same directory as this script.

#To generate something, it must be written as var=***** 8 to get a generated
#length of 8

import re
import random
import string

def randomRegexableString(stringLength=16):
    letters = string.ascii_lowercase + string.ascii_uppercase + string.digits
    generated_string = ''.join(random.choice(letters) for i in range(stringLength))
    return generated_string

f = open('./env', 'r')
file_lines = f.readlines()
f.close()
new_file_lines = []

for line in file_lines:
    new_line = line
    if '*****' in line:
        index_of_first_asterisk = line.find('*****')
        length_string = line.split()[-1]
        new_line = line[0:index_of_first_asterisk] + randomRegexableString(int(length_string))
    elif 'DB_CONNECTION_STRING' in line:
        index_of_first_equals = line.find('=')
        new_line = line[0:index_of_first_equals] + re.escape(line[index_of_first_equals:])
        new_line = new_line.replace('/', '\\/')
    new_file_lines.append(new_line)

f = open('./env', 'w')
for i in range(len(new_file_lines)):
    if i == len(new_file_lines):
        f.write(new_file_lines[i])
    else:
        f.write(new_file_lines[i]+'\n')
f.close()
