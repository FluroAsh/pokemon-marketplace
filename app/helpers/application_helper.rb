module ApplicationHelper
  include Pagy::Frontend # makes pagy frontend helpers available in our views

  def singularize(string) # targets any spaces and characters after it
    string.gsub(/\s.+/, "") if string.respond_to?(:to_s)
  end

  def purge_s_brackets(string)
    string.gsub(/"|\[|\]/, "") if !string.nil?
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

  def remove_sprite_junk(name)
    # needs to be maintained/updated for larger set size, but illustrates basic method
    name.gsub(/Dark |Team Aqua's |-EX|Erika's |Blaine's | FB| G| δ| V|Alolan |Brock'|M |Detective| Gl|/i, "").strip
  end

  def card_prices(id)
    card = Pokemon::Card.find(id)
    return card.cardmarket.prices
    ## // (relevant) object elements //
    #  @average_sell_price
    #  @avg1
    #  @avg30
    #  @avg7
    #  @low_price
    #  @low_price_ex_plus
    #  @suggested_price
    #  @trend_price
    ## //
  end

  def format_price(price)
    # sprintf ('string, print, format' basically...) takes 2 arguments, the format and our value
    # https://apidock.com/ruby/Kernel/sprintf
    sprintf("$%2.2f", (price / 100.0))
  end
end
