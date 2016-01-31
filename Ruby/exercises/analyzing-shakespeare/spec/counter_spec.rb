require 'nokogiri'

require 'counter'

describe Counter do
  before(:all) do
    @counter = Counter.new

    @document_string = <<-eos
      <PLAY>
        <ACT>
          <SCENE>
            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <LINE>When shall we three meet again</LINE>
              <LINE>In thunder, lightning, or in rain?</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>Second Witch</SPEAKER>
              <LINE>When the hurlyburly's done,</LINE>
              <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>Third Witch</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <LINE>Where the place?</LINE>
            </SPEECH>
          </SCENE>
        </ACT>
        <ACT>
          <SCENE>
            <SPEECH>
              <SPEAKER>ALL</SPEAKER>
              <LINE>Fair is foul, and foul is fair:</LINE>
              <LINE>Hover through the fog and filthy air.</LINE>
            </SPEECH>
          </SCENE>
        </ACT>
      </PLAY>
    eos
    @document = Nokogiri::XML(@document_string)
  end

  # TODO
  it 'finds the individual characters (but not ALL) in the play' do
    characters = @counter.find_characters(@document)

    expect(characters).to match_array([ 'First Witch', 'Second Witch', 'Third Witch' ])
  end
end
