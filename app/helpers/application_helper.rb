module ApplicationHelper
  include Pagy::Frontend # makes pagy frontend helpers available in our views

  def singularize(string) # targets any spaces and characters after it
    string.gsub(/\s.+/, "") if string.respond_to?(:to_s)
  end

  def purge_s_brackets(string)
    string.gsub(/"|\[|\]/, "")
  end

  def url_lg_sprite(pokedex_num) # backup sprite
    "https://www.pkparaiso.com/imagenes/xy/sprites/pokemon/#{pokedex_num}.png"
  end

  def url_sm_sprite_et(name) # evolves_to is arr of strings in postgres
    # gsub removes phantom \'s & square brackets
    purge_s_brackets("https://img.pokemondb.net/sprites/black-white/anim/normal/#{name.gsub('"', "").downcase}.gif")
  end

  def url_sm_sprite_ef(name) # evolves from with url
    purge_s_brackets("https://img.pokemondb.net/sprites/black-white/anim/normal/#{name.gsub('"', "").downcase}.gif")
  end

  def remove_sprite_junk(name) # callable version for processing strings in view
    # needs to be iterated upon as set size grows larger (> 1 page)
    name.gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| V|Alolan |Brock's/, "").strip
  end
end
