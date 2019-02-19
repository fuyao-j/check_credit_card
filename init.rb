class CheckCreditCard
  attr_reader :card_number
  def initialize(card_number)
    @card_number = card_number
  end

  def valid?
    parsed_numbers = @card_number.delete('^0-9')
    return false if parsed_numbers.size >= 13 and parsed_numbers.size <= 16
    digits = parsed_numbers.split('')
    sum = 0
    digits.each_with_index do |digit, index|
      d = digit.to_i
      if index.odd?
        sum += d
      else
        q, r = (d + d).divmod(10)
        sum += q + r
      end
    end
    sum % 10 == 0
  end
end
