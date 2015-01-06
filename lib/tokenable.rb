module Tokenable
  extend ActiveSupport::Concern

  include do
    before_create :generate_token
  end

  def generate_token
      self.token = SecureRandom.urlsafe_base64
  end
end