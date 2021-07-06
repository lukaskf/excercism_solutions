=begin
Write your code for the 'Word Count' exercise in this file. Make the tests in
`word_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/word-count` directory.
=end

class Phrase
  def initialize(sentence)
    @sentence = sentence
  end

  # def upsert_word
  #   unless @word.empty?
  #     @word = @word.gsub(/( '|' )/, ' ')
  #
  #     if @result.has_key? @word
  #       @result[@word] += 1
  #     else
  #       @result[@word] = 1
  #     end
  #     @word = ""
  #   end
  # end
  #
  # def old_word_count
  #   @result = {}
  #   @word = ""
  #   @sentence.split('').each do |letter|
  #     if letter.match?(/[[:alpha:]]/) || letter.match?(/[[:digit:]]/) || letter == "'"
  #       @word += letter.downcase
  #     else
  #       upsert_word
  #     end
  #   end
  #   upsert_word
  #   @result
  # end

  def word_count
    result = Hash.new 0

    unless @sentence.empty?
      @sentence = @sentence.gsub(/[^0-9A-Za-z']/, ' ') #replace special characters with whitespace
      @sentence = @sentence.strip.squeeze(' ') #remove leading/trailing whitespace and multiple white space

      @sentence.split(' ').each do |word|
        word = word.gsub(/^\'|\'?$/, '').downcase #remove single quotes around word (e.g. 'foo' -> foo)
        result[word] += 1
      end
    end

    result
  end
end
