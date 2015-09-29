import argparse

from words import Finder

parser = argparse.ArgumentParser(description='Find words that only contain the specified characters.')

# Positional arguments
parser.add_argument('characters', metavar='CHARACTERS', nargs=1,
                    help='The characters that the resulting words can contain')

# Optional arguments
parser.add_argument('--file', dest='file', default='./SOWPODS.txt',
                    help='The file in which the program looks for matching words (Default: ./SOWPODS.txt)')

args = parser.parse_args()

f = open(args.file)
lines = f.read().splitlines()

f.close()

finder = Finder()

words = finder.words_that_contain_any(lines, args.characters[0])

print(str(len(words)) + " matching (out of " + str(len(lines)) + " total) words found: " + ', '.join(words))
