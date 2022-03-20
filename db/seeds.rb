include SeedHelper # included for object sanitization (weaknesses, resistances, etc).
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup)

## DELETES OLD RECORDS ##
## Children
Favourite.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("favourites") # reset id sequence to 1
Order.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("orders")
Listing.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("listings")
Profile.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("profiles")
## Parents
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("users")
Card.delete_all # string id, no reset required
CardSet.delete_all
##

## API Doc: https://github.com/PokemonTCG/pokemon-tcg-sdk-ruby
# Creates clean requests to the API to retrieve ALL card data
# >> change 'page: 1' to a different number to retrieve different data
# cards = Pokemon::Card.where(page: 1, pageSize: 50) # only get first 50 cards for testing
cards = Pokemon::Card.all.first(5000)
sets = Pokemon::Set.all

# Creates a new card/cardset for each unique card we passed into our cards variable
# Saves time by loading from our DB rather than external API -- useful for Heroku Deployment
if CardSet.count == 0
  i = 0
  puts "----------------------------------------------"
  sets.each do |set|
    i += 1
    CardSet.create( # change to TCGSet in next iteration, so we don't clean a conflict when we generate CardSet join table model & TCGSet model
      id: set.id,
      name: set.name,
      series: set.series,
      printed_total: set.printed_total,
      symbol: set.images.symbol,
      logo: set.images.logo,
    )
    p "(#{i})-[#{set.id}] -> #{set.name} set successfully created"
  end
  puts "----------------------------------------------"
  p "***(#{i}) CARD SETS CREATED*** ✅"
end

if Card.count == 0
  i = 0
  puts "----------------------------------------------"
  cards.each do |card|
    i += 1
    Card.create(
      id: card.id, # Reset ID Seq. PSQL: ALTER SEQUENCE cards_id_seq RESTART WITH 1;
      card_set_id: card.set.id, # preset set_id, so we can reference CardSet.id later ()
      name: card.name,
      sprite_name: card.name, # to be used with "https://pokemondb.net/sprites"
      supertype: card.supertype,
      subtypes: card.subtypes,
      level: card.level,
      ability_name: clean_ability_name(card.abilities),
      ability_text: clean_ability_text(card.abilities),
      types: card.types,
      weaknesses: clean_weakness_type(card.weaknesses),
      resistances: clean_resistance_type(card.resistances),
      retreat_cost: card.retreat_cost,
      converted_retreat_cost: card.converted_retreat_cost,
      evolves_from: card.evolves_from,
      evolves_to: card.evolves_to,
      flavor_text: card.flavor_text,
      rules: clean_rule_text(card.rules), # TO:DO - FIX! -- Extract the string
      number: card.number,
      rarity: card.rarity,
      national_pokedex_number: card.national_pokedex_numbers,
      small_image: card.images.small,
      large_image: card.images.large,
    )
    p "(#{i})-[#{card.id}] -> #{card.name} card successfully created"
  end
  puts "----------------------------------------------"
  p "***(#{i}) CARDS CREATED*** ✅"
  puts "----------------------------------------------"
end
