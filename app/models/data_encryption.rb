class DataEncryption
  ## Initialize Public Key Path
  def initialize
    @public_key_str = "#{Rails.root}/config/decryption/test.pub.pem"
  end

  ## Generate Public Key Object
  def public_key
    OpenSSL::PKey::RSA.new(File.read(@public_key_str),"12345678")
  end

  ## Encrypt Details
  def encrypted_data(encrypted_string)
    Base64.encode64(public_key.public_encrypt(encrypted_string))
  end
end