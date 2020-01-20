<<<<<<< 453ca399621458804e145a3719fd65ed34bd7118
# frozen_string_literal: true

# This object returns headers needed for authentication
# This authentication method is more secure, but more tedious
# https://uploadcare.com/docs/api_reference/rest/requests_auth/#auth-uploadcare
=======
# This class is essentially a semaphore object,
# deciding which authentication mechanism to use
>>>>>>> feat: use secure authentication

require 'digest/md5'

module Uploadcare
  class AuthenticationHeader
<<<<<<< 453ca399621458804e145a3719fd65ed34bd7118
    def self.call(method: 'GET', content: '', content_type: 'application/json', uri: '')
      @method = method
      @content = content
      @content_type = content_type
      @uri = uri
      @date_for_header = timestamp
      {
        'Date': @date_for_header,
        'Authorization': "Uploadcare #{PUBLIC_KEY}:#{signature}"
      }
    end

    protected

    def self.signature
      content_md5 = Digest::MD5.hexdigest(@content)
      sign_string = [@method, content_md5, @content_type, @date_for_header, @uri].join("\n")
      digest = OpenSSL::Digest.new('sha1')
      OpenSSL::HMAC.hexdigest(digest, SECRET_KEY, sign_string)
    end

    def self.timestamp
      Time.now.gmtime.strftime('%a, %d %b %Y %H:%M:%S GMT')
=======
    def self.call(**options)
      case AUTH_TYPE
      when 'Uploadcare'
        SecureAuthHeader.call(options)
      when 'Uploadcare.Simple'
        SimpleAuthHeader.call
      else
        raise ArgumentError, "Unknown auth_scheme: '#{AUTH_TYPE}'"
      end
>>>>>>> feat: use secure authentication
    end
  end
end
