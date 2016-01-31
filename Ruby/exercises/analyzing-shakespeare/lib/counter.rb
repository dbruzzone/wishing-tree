require 'open-uri'

require 'nokogiri'

class Counter
  def get_document(url)
    Nokogiri::HTML(open(url))
  end

  def find_characters(document)
    # This isn't ideal... Like its Nodes, Nokogiri's NodeSets have a text method.
    # However, it returns a string (and not a collection) that contains every Node's text...
    #
    # For example, '<speaker>One</speaker>', '<speaker>Two</speaker>' and '<speaker>Three</speaker>'
    # are returned as 'OneTwoThree'...
    #
    # ...So we extract each speaker node's text by iterating over all the speaker nodes...
    results = []

    document.xpath('//act/scene/speech/speaker').each do |node|
      character_name = node.text

      # ...However, this extra step does provide an opportunity to exclude certain
      # characters (which could also be done in a separate step with Enumerable's
      # reject or Array's delete_if methods)
      results << character_name unless character_name.eql? 'ALL'
    end

    results.uniq
  end

  def count_lines_spoken_by_characters(document)
    speaker_line_counts = {} 

    # Iterate over every speech in the play
    document.xpath('//act/scene/speech').each do |speech|
      speaker_name = ''

      speech.children.each do |child_node|
        case child_node.name
        when 'speaker'
          # Does the speaker exist in result?
          speaker_name = child_node.inner_text

          break if speaker_name.eql? 'ALL'

          unless speaker_line_counts.has_key? speaker_name
            speaker_line_counts[speaker_name] = 0
          end
        when 'line'
          speaker_line_counts[speaker_name] = speaker_line_counts[speaker_name] + 1
        end
      end
    end

    speaker_line_counts
  end
end
