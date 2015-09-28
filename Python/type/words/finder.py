class Finder:
    def words_that_contain(self, words, characters):
        result = []

        # Loop through words...
        for word in words:
            checked_characters = "" 
            include_word = True

            # ...Then through each character in word
            for character in word:
                # If character hasn't previously been checked (If it has, skip it to speed the process
                # up a bit)...
                if character not in checked_characters:
                    # ...And it isn't in the list of characters that word must contain...
                    if character not in characters:
                        # ...Don't include word in result
                        include_word = False

                    checked_characters += character

            # Have all the characters in characters been checked?...
            if len(characters) != len(checked_characters):
                # If they haven't, word does not and cannot contain all the characters in characters.
                # This catches (admitedly unlikely) cases like "Does 'BBB' contain 'BD'?" (It
                # shouldn't)
                include_word = False

            if include_word:
                result.append(word) 

        return result
