import os.path

from flask import Flask, jsonify

from finder import Finder

app = Flask(__name__)

APP_ROOT = os.path.realpath(os.path.dirname(__file__))
word_file = os.path.join(APP_ROOT, "data", "SOWPODS.txt")

@app.route('/find-words-with/<characters>')
def find_words_with(characters):
    f = open(word_file)

    lines = f.read().splitlines()

    f.close()

    finder = Finder()

    matching_words = finder.words_that_contain_any(lines, characters)

    return jsonify(total_words = len(lines), matching_words = len(matching_words), words = matching_words)
