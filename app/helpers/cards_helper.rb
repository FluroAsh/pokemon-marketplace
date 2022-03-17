module CardsHelper
  def format_condition(int)
    case int
    when 1
      "Poor"
    when 2
      "Good"
    when 3
      "Fair"
    when 4
      "Excellent"
    when 5
      "Mint"
    end
  end
end
