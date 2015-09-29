import unittest

from words import Finder

class TestWordFinder(unittest.TestCase):

    _words = [ 'AAA', 'AAB', 'ABB', 'BBB', 'BBC', 'BCC', 'CCC', 'BDD' ]

    _finder = Finder()

    def test_find_words_that_contain_any(self):
        self.assertEqual(len(self._words), 8)

        self.assertEqual(len(self._finder.words_that_contain_any(self._words, 'Z')), 0)
        self.assertEqual(len(self._finder.words_that_contain_any(self._words, 'A')), 1)
        self.assertEqual(len(self._finder.words_that_contain_any(self._words, 'AB')), 4)
        self.assertEqual(len(self._finder.words_that_contain_any(self._words, 'BD')), 2)

    def test_find_words_that_contain_all(self):
        self.assertEqual(len(self._finder.words_that_contain_all(self._words, 'Z')), 0)
        self.assertEqual(len(self._finder.words_that_contain_all(self._words, 'A')), 1)
        self.assertEqual(len(self._finder.words_that_contain_all(self._words, 'AB')), 2)
        self.assertEqual(len(self._finder.words_that_contain_all(self._words, 'BD')), 1)

if __name__ == '__main__':
    unittest.main()
