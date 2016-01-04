class StringUtils
  def self.generate_random_string(length)
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    text = ''

    length.times do
      text << possible[ (rand.round(2) * possible.length).floor - 1 ]
    end

    text
  end
end
