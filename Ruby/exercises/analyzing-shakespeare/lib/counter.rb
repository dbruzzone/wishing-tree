require 'open-uri'

require 'nokogiri'

class Counter
  def lines_spoken_by_characters(url)
    document = Nokogiri::HTML(open(url))

    count_lines_spoken_by_characters(document)
  end

  def find_characters(document)
    # This isn't ideal... Like its Nodes, Nokogiri's NodeSets have an inner_html method.
    # However, it returns a string (and not a collection) that contains every Node's inner_html...
    #
    # For example, '<SPEAKER>One</SPEAKER>', '<SPEAKER>Two</SPEAKER>' and '<SPEAKER>Three</SPEAKER>'
    # are returned as 'OneTwoThree'...
    result = []

    document.xpath('//ACT/SCENE/SPEECH/SPEAKER').each do |node|
      character_name = node.inner_html

      # ...However, having to take this extra step does provide an opportunity to exclude certain
      # characters (which could also be done in a separate step with Enumerable's reject or Array's
      # delete_if methods)
      result << character_name unless character_name.eql? 'ALL'
    end

    result.uniq
  end

  def count_lines_spoken_by_characters(document)
    result = []

    # TODO

    result
  end
end
