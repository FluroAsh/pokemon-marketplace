module ApplicationHelper
  include Pagy::Frontend # makes pagy frontend helpers available in our views

  def singularize(string) # targets any spaces and characters after it
    string.gsub(/\s.+/, "") if string.respond_to?(:to_s)
  end

  def url_lg_sprite(pokedex_num)
    "https://www.pkparaiso.com/imagenes/xy/sprites/pokemon/#{pokedex_num}.png"
  end

  def url_sm_sprite_et(name) # evolves_to is arr of strings in postgres
    # gsub removes phantom \'s
    "https://img.pokemondb.net/sprites/sword-shield/icon/#{name.gsub('"', "").downcase}.png"
  end

  def url_sm_sprite_ef(name) # evolves from with url
    puts name
    "https://img.pokemondb.net/sprites/sword-shield/icon/#{name.gsub('"', "").downcase}.png"
  end

  ## Add helper method to remove 'dark' and other various prefixes from the pokemon's name
end

# <%= image_tag "#{get_mini_sprite(card.evolves_to[(/"(.*?)"/)].downcase)}", style: "height:50px;"%>
# <% p "#{get_mini_sprite(card.evolves_to[(/"(.*?)"/)].downcase)}"%>

## Prev
# <%= image_tag "#{get_mini_sprite(card.evolves_to)}", style: "height:50px;"%>
