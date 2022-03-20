module SeedHelper
  # unable to iterate through objects in card model -- doing it here instead
  def clean_weakness_type(weaknesses) # gets type from weaknesses object
    weaknesses.map { |obj| obj.type }.first if !weaknesses.nil?
  end

  def clean_resistance_type(resistances) # gets type from resistances object
    resistances.map { |obj| obj.type }.first if !resistances.nil?
  end

  def clean_ability_name(abilities) # gets name from abilities object
    abilities.map { |obj| obj.name.to_s }.first if !abilities.nil?
  end

  def clean_ability_text(abilities) # gets text from abilities object
    abilities.map { |obj| obj.text.to_s }.first if !abilities.nil?
  end

  def clean_rule_text(rules) # converts rules object array to string
    rules.map { |obj| obj.to_s }.first if !rules.nil?
  end
end
