require 'award'

def update_quality(awards)
  awards.each do |award|
    ############## decreasing normal awards quality #############
    if award.name != 'Blue First' && award.name != 'Blue Compare'

      # this takes into account the edge case of quality = 0
      # and to prevent it from going negative
      if award.quality > 0 && award.name == 'Blue Star'
        award.quality -= 1
      end
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end
      end
    ##############################################################

    ################ increasing special awards quality ###########
    else
      if award.quality < 50
        # increasing for Blue First
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    ##############################################################

    ######### decreases expiration time all other awards #########
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    ##############################################################

    ######### addresses the effects of expired awards ############
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'

          # this takes into account the edge case of quality = 0
          # to prevent it from going negative
          if award.quality > 0 && award.name == 'Blue Star'
            award.quality -= 1
          end
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
    ##############################################################

  end

end
