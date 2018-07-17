class CommonFunction

  def self.validate_input(user_input)
    isValid = false
    return isValid if !(user_input.is_a? Array)
    unless user_input.any?
      return isValid
    else
      user_input.map do |item|
        if (item.is_a? Array) && (item.length == 2)
          isValid = true
          item.map{|i| isValid = false if !(i.is_a? Integer) }
        else
          isValid = false
          break
        end
      end
    end
    return isValid
  end

end
