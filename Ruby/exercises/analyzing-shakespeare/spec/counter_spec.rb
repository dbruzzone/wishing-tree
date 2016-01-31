require 'nokogiri'

require 'counter'

describe Counter do
  before(:all) do
    @counter = Counter.new

    @document_string = <<-eos
      <play>
        <act>
          <scene>
            <speech>
              <speaker>First Witch</speaker>
              <line>When shall we three meet again</line>
              <line>In thunder, lightning, or in rain?</line>
            </speech>
            <speech>
              <speaker>Second Witch</speaker>
              <line>When the hurlyburly's done,</line>
              <line>When the battle's lost and won.</line>
            </speech>
            <speech>
              <speaker>Third Witch</speaker>
              <line>That will be ere the set of sun.</line>
            </speech>
            <speech>
              <speaker>First Witch</speaker>
              <line>Where the place?</line>
            </speech>
          </scene>
        </act>
        <act>
          <scene>
            <speech>
              <speaker>ALL</speaker>
              <line>Fair is foul, and foul is fair:</line>
              <line>Hover through the fog and filthy air.</line>
            </speech>
          </scene>
        </act>
        <act>
          <scene>
            <speech>
              <speaker>ALL</speaker>
              <line>So all.</line>
            </speech>
            <speech>
              <speaker>MACBETH</speaker>
              <line>Let's briefly put on manly readiness,</line>
              <line>And meet i' the hall together.</line>
            </speech>
          </scene>
        </act>
      </play>
    eos
    @document = Nokogiri::XML(@document_string)
  end

  it 'finds the individual characters (but not ALL) in the play' do
    characters = @counter.find_characters(@document)

    expect(characters.size).to eq(4)

    expect(characters).to include('First Witch', 'Second Witch', 'Third Witch', 'MACBETH')
  end

  it "counts the lines spoken by each character (but not the ALL 'character') in the play" do
    lines_spoken_by_characters = @counter.count_lines_spoken_by_characters(@document)

    expect(lines_spoken_by_characters.size).to eq(4)

    expect(lines_spoken_by_characters).to include('First Witch' => 3, 'Second Witch' => 2, 'Third Witch' => 1, 'MACBETH' => 2)
  end
end
