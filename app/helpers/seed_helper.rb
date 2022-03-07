module SeedHelper
    def convert_pdex_num(pdex_num)
        if pdex_num != nil
            national_pdex_nums = ("%03d" % "#{(pdex_num.first.to_s.gsub("/\[]\/", "")).to_i}") # removes square brackets & converts to 3 digit format
        else # else return nil val
            national_pdex_nums = pdex_num
        end
    end

    def clean_evolves_from(e_from)
        e_from.to_s if !e_from.nil?
    end

    def clean_weakness_type(weaknesses)
        weaknesses.map { |obj| obj.type }.first if !weaknesses.nil?
    end
    
    def clean_resistance_type(resistances)
        resistances.map { |obj| obj.type }.first if !resistances.nil?
    end

    def clean_ability_name(abilities)
        abilities.map { |obj| obj.name.to_s }.first if !abilities.nil?
    end
    
    def clean_ability_text(abilities)
        abilities.map { |obj| obj.text.to_s }.first if !abilities.nil?
    end

    def clean_rule_text(rules)
        rules.map { |obj| obj.to_s }.first if !rules.nil?
    end
end

