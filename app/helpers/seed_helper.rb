module SeedHelper

    ## Can be moved to card model as a callback (before_save)
    def convert_pdex_num(pdex_num) # removes square brackets & converts to 3 digit (000) format
        if pdex_num != nil
            national_pdex_nums = ("%03d" % "#{(pdex_num.first.to_s.gsub("/\[]\/", "")).to_i}") 
        else # else return nil val
            national_pdex_nums = pdex_num
        end
    end

    def clean_evolves_from(e_from) # converts array to string
        e_from.to_s if !e_from.nil?
    end

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

