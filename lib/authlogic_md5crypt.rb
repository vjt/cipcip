require 'facets/crypt'
 
module Authlogic
  module CryptoProviders
    class MD5Crypt
      class << self
        attr_accessor :join_token
        
        # The number of times to loop through the encryption.
        def stretches
          @stretches ||= 1
        end
        attr_writer :stretches
        
        # Turns your raw password into a MD5 hash.
        def encrypt(*tokens)
          digest = nil
          stretches.times { digest = crypt(tokens) }
          digest
        end
        
        # Does the crypted password match the tokens? Uses the same tokens that were used to encrypt.
        def matches?(crypted, *tokens)
          algo, salt, hash = crypted.scan(/\$(\w+)/).flatten
          raise "Unsupported algorithm (#{algo})" unless algo == "1"

          crypt(tokens, salt) == crypted
        end

        private
          def crypt(tokens, salt = nil, magic = '$1$')
            digest = tokens.flatten.join(join_token)
            Crypt.crypt(digest, :md5, salt, magic)
          end
      end
    end
  end
end
