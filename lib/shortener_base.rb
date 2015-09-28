module ShortenerBase
  require "base64"

  def self.encode
      (('a'..'z').to_a + (1..9).to_a).shuffle[0,9].join
  end

end
