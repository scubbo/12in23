class Cipher

    FIRST_ASCII_INDEX = 97
    ALPHABET = "abcdefghijklmnopqrstuvwxyz"
    KEY_REGEX = Regexp.new('^[a-z]+$').freeze

    attr_reader :key

    def initialize(key = nil)
        if key != nil and !KEY_REGEX.match?(key)
            raise ArgumentError
        end
        @key = key != nil ? key : (0...1000).map { (FIRST_ASCII_INDEX + rand(ALPHABET.size)).chr }.join
    end

    def encode(plaintext)
        somecode(plaintext, 'encode')
    end

    def decode(ciphertext)
        somecode(ciphertext, 'decode')
    end

    def somecode(text, operation)
        text.chars.map.with_index { |l, i|
            cipher_value = @key[i % @key.size].ord() - FIRST_ASCII_INDEX

            case operation
            when 'encode'
                idx = ALPHABET.index(l) + cipher_value
            when 'decode'
                idx = ALPHABET.index(l) - cipher_value
            else
                raise "Unexpected operation #{operation}"
            end

            ALPHABET[idx % ALPHABET.size]
        }.join
    end
end
