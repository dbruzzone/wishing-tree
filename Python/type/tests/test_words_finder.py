import unittest

from words import Finder

class TestWordFinder(unittest.TestCase):

    _words = [ 'AAA', 'AAB', 'ABB', 'BBB', 'BBC', 'BCC', 'CCC', 'BDD' ]

    def test_find_words_that_contain(self):
        self.assertEqual(len(self._words), 8)

        finder = Finder()

        self.assertEqual(len(finder.words_that_contain(self._words, 'Z')), 0)
        self.assertEqual(len(finder.words_that_contain(self._words, 'A')), 1)
        self.assertEqual(len(finder.words_that_contain(self._words, 'AB')), 2)
        self.assertEqual(len(finder.words_that_contain(self._words, 'BD')), 1)

if __name__ == '__main__':
    unittest.main()
