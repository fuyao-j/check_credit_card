class CheckCreditCard
  def initialize(card_number)
    @card_number = card_number
    @number = @card_number.delete('^0-9')
  end

  def valid?
    return false unless @number.size >= 13 && @number.size <= 16
    digits = @number.split('')
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

  def card_type
    return 'amex'         if @number.size == 15 && @number =~ /^3[47]/
    return 'discover'     if @number.size == 16 && @number =~ /^6011/
    return 'mastercard'   if @number.size == 16 && @number =~ /^5[1-5]/
    return 'visa'         if [13,16].include?(@number.length) && @number =~ /^4/

    return 'unknown'
  end
end

card_number = gets.chomp
cc = CheckCreditCard.new(card_number)

if cc.valid?
  puts 'This that card is valid.'
  puts 'Card type: ' + cc.card_type
else
  puts 'That card is not valid.'
end