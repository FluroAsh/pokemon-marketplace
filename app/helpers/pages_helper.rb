module PagesHelper
  def get_random_card_sprite # used on the home page
    card = Card.order("RANDOM()").first # consistently more effecient than a .pluck or .sample method
    if File.file?("#{Rails.root}/app/assets/images/#{card.sprite_name.downcase}.gif") # checks to see if file with sprite name exists (gif sprite)
      image_tag "#{card.sprite_name.downcase}.gif", class: "gif-sprite", title: remove_sprite_junk(card.name), alt: card.name
    else # backup sprite
      image_tag "#{url_lg_sprite(card.national_pokedex_number)}", class: "png-sprite", alt: remove_sprite_junk(card.name), title: card.name, style: "height:100px;"
    end
  end
end
