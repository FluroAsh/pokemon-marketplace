module ListingsHelper
  def get_card_sprite # assumes we have already set @card in listings controller
    if File.file?("#{Rails.root}/app/assets/images/#{@card.sprite_name.downcase}.gif") # checks to see if file with sprite name exists (gif sprite)
      image_tag "#{@card.sprite_name.downcase}.gif", class: "gif-sprite", title: remove_sprite_junk(@card.sprite_name), alt: @card.sprite_name
    end # if nothing returned then it doesn't exist --> display empty col, retain layout
  end
end
