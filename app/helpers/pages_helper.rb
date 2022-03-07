module PagesHelper
    def get_random_card_sprite # used on the home page
        card = Card.order("RANDOM()").first # consistently more effecient than a .pluck or .sample method
        if File.file?("#{Rails.root}/app/assets/images/#{card.sprite_name.downcase}.gif")
            image_tag "#{card.sprite_name.downcase}.gif", class: "gif-sprite", alt: card.name 
        else 
            image_tag "#{url_lg_sprite(card.national_pokedex_number)}", class: "png-sprite", alt: card.name, style: "height:100px;"
        end 
    end
end
