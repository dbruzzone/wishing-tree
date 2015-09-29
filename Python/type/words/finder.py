import collections

class Finder:
    def words_that_contain_any(self, words, characters):
        result = []

        # Loop through words...
        for word in words:
            word_contains = self._word_contains(word, characters)
            include_word = word_contains[0]

            if include_word:
                result.append(word) 

        return result

    def words_that_contain_all(self, words, characters):
        result = []

        # Loop through words...
        for word in words:
            word_contains = self._word_contains(word, characters)
            include_word = word_contains[0]

            # Have all the characters in characters been checked?...
            if len(characters) != len(word_contains[1]):
                # If they haven't, word does not and cannot contain all the characters in characters.
                # This catches (admitedly unlikely) cases like "Does 'BBB' contain 'BD'?" (It
                # shouldn't)
                include_word = False

            if include_word:
                result.append(word) 

        return result

    def _word_contains(self, word, characters):
        result = True
        checked_characters = ""

        for character in word:
            # If character hasn't previously been checked (If it has, skip it to speed the process
            # up a bit)...
            if character not in checked_characters:
                # ...And it isn't in the list of characters that word must contain...
                if character not in characters:
                    # ...Don't include word in result
                    result = False

                checked_characters += character

        return (result, checked_characters)
