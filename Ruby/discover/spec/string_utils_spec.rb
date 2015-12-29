require "string_utils"

describe StringUtils do
  describe ".generate_random_string" do
    context "given a length argument equal to 10" do
      it "returns a string that's 10 characters long" do
        expect(StringUtils.generate_random_string(10).length).to eql(10)
      end

      it "returns a random string that only contains the allowed alphanumeric characters" do
        # The allowed alphanumeric characters are 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        expect(StringUtils.generate_random_string(10)).to match(/^[A-Za-z0-9]+$/)
      end
    end
  end
end
