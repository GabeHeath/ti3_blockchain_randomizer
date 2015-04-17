module RandomizersHelper
  def get_rand_player_name(instance, player)
    rand_players = []
    rand_players.push(instance.rand_p1)
    rand_players.push(instance.rand_p2)
    rand_players.push(instance.rand_p3)
    rand_players.push(instance.rand_p4)
    rand_players.push(instance.rand_p5)
    rand_players.push(instance.rand_p6)
    rand_players.push(instance.rand_p7)
    rand_players.push(instance.rand_p8)

    rand_player_blocks = []
    rand_player_blocks.push(instance.p1_hash)
    rand_player_blocks.push(instance.p2_hash)
    rand_player_blocks.push(instance.p3_hash)
    rand_player_blocks.push(instance.p4_hash)
    rand_player_blocks.push(instance.p5_hash)
    rand_player_blocks.push(instance.p6_hash)
    rand_player_blocks.push(instance.p7_hash)
    rand_player_blocks.push(instance.p8_hash)

    unless rand_players[player - 1].blank?
      return ("#{rand_players[player - 1]}" + break_tag + "#{content_tag(:span,rand_player_blocks[player - 1], class: ['small-block-text'])}").html_safe
    else
      return ("-").html_safe
    end
  end

  def get_rand_player_race(instance, player)

    # Right now only works with 6 players. Add other distributions if more or less players

    case player
      when 1
          return (get_rand_race(instance, 1) + break_tag + get_rand_race(instance, 7)  + break_tag + get_rand_race(instance, 13)).html_safe
      when 2
        return (get_rand_race(instance, 2) + break_tag + get_rand_race(instance, 8)  + break_tag + get_rand_race(instance, 14)).html_safe
      when 3
        return (get_rand_race(instance, 3) + break_tag + get_rand_race(instance, 9)  + break_tag + get_rand_race(instance, 15)).html_safe
      when 4
        return (get_rand_race(instance, 4) + break_tag + get_rand_race(instance, 10)  + break_tag + get_rand_race(instance, 16)).html_safe
      when 5
        return (get_rand_race(instance, 5) + break_tag + get_rand_race(instance, 11)  + break_tag + get_rand_race(instance, 17)).html_safe
      when 6
        return (get_rand_race(instance, 6) + break_tag + get_rand_race(instance, 12)  + break_tag + get_rand_race(instance, 18)).html_safe
    end
  end

  def get_rand_player_block(instance, player)

    # Right now only works with 6 players. Add other distributions if more or less players

    case player
      when 1
        return (get_rand_block(instance, 1) + break_tag + get_rand_block(instance, 7)  + break_tag + get_rand_block(instance, 13)).html_safe
      when 2
        return (get_rand_block(instance, 2) + break_tag + get_rand_block(instance, 8)  + break_tag + get_rand_block(instance, 14)).html_safe
      when 3
        return (get_rand_block(instance, 3) + break_tag + get_rand_block(instance, 9)  + break_tag + get_rand_block(instance, 15)).html_safe
      when 4
        return (get_rand_block(instance, 4) + break_tag + get_rand_block(instance, 10)  + break_tag + get_rand_block(instance, 16)).html_safe
      when 5
        return (get_rand_block(instance, 5) + break_tag + get_rand_block(instance, 11)  + break_tag + get_rand_block(instance, 17)).html_safe
      when 6
        return (get_rand_block(instance, 6) + break_tag + get_rand_block(instance, 12)  + break_tag + get_rand_block(instance, 18)).html_safe
    end
  end

  def no_block
    return content_tag(:div, "", class: ["glyphicon", "glyphicon-minus"])
  end

  def break_tag
    return content_tag(:br)
  end

  def get_rand_race(instance, race_num)
    case race_num
      when 1
        unless instance.rand_r1.blank?
          return instance.rand_r1
        else
          return "-"
        end
      when 2
        unless instance.rand_r2.blank?
          return instance.rand_r2
        else
          return "-"
        end
      when 3
        unless instance.rand_r3.blank?
          return instance.rand_r3
        else
          return "-"
        end
      when 4
        unless instance.rand_r4.blank?
          return instance.rand_r4
        else
          return "-"
        end
      when 5
        unless instance.rand_r5.blank?
          return instance.rand_r5
        else
          return "-"
        end
      when 6
        unless instance.rand_r6.blank?
          return instance.rand_r6
        else
          return "-"
        end
      when 7
        unless instance.rand_r7.blank?
          return instance.rand_r7
        else
          return "-"
        end
      when 8
        unless instance.rand_r8.blank?
          return instance.rand_r8
        else
          return "-"
        end
      when 9
        unless instance.rand_r9.blank?
          return instance.rand_r9
        else
          return "-"
        end
      when 10
        unless instance.rand_r10.blank?
          return instance.rand_r10
        else
          return "-"
        end
      when 11
        unless instance.rand_r11.blank?
          return instance.rand_r11
        else
          return "-"
        end
      when 12
        unless instance.rand_r12.blank?
          return instance.rand_r12
        else
          return "-"
        end
      when 13
        unless instance.rand_r13.blank?
          return instance.rand_r13
        else
          return "-"
        end
      when 14
        unless instance.rand_r14.blank?
          return instance.rand_r14
        else
          return "-"
        end
      when 15
        unless instance.rand_r15.blank?
          return instance.rand_r15
        else
          return "-"
        end
      when 16
        unless instance.rand_r16.blank?
          return instance.rand_r16
        else
          return "-"
        end
      when 17
        unless instance.rand_r17.blank?
          return instance.rand_r17
        else
          return "-"
        end
      when 18
        unless instance.rand_r18.blank?
          return instance.rand_r18
        else
          return "-"
        end
    end
  end


  def get_rand_block(instance, race_num)
    case race_num
      when 1
        unless instance.r1_hash.blank?
          return instance.r1_hash
        else
          return "-"
        end
      when 2
        unless instance.r2_hash.blank?
          return instance.r2_hash
        else
          return "-"
        end
      when 3
        unless instance.r3_hash.blank?
          return instance.r3_hash
        else
          return "-"
        end
      when 4
        unless instance.r4_hash.blank?
          return instance.r4_hash
        else
          return "-"
        end
      when 5
        unless instance.r5_hash.blank?
          return instance.r5_hash
        else
          return "-"
        end
      when 6
        unless instance.r6_hash.blank?
          return instance.r6_hash
        else
          return "-"
        end
      when 7
        unless instance.r7_hash.blank?
          return instance.r7_hash
        else
          return "-"
        end
      when 8
        unless instance.r8_hash.blank?
          return instance.r8_hash
        else
          return "-"
        end
      when 9
        unless instance.r9_hash.blank?
          return instance.r9_hash
        else
          return "-"
        end
      when 10
        unless instance.r10_hash.blank?
          return instance.r10_hash
        else
          return "-"
        end
      when 11
        unless instance.r11_hash.blank?
          return instance.r11_hash
        else
          return "-"
        end
      when 12
        unless instance.r12_hash.blank?
          return instance.r12_hash
        else
          return "-"
        end
      when 13
        unless instance.r13_hash.blank?
          return instance.r13_hash
        else
          return "-"
        end
      when 14
        unless instance.r14_hash.blank?
          return instance.r14_hash
        else
          return "-"
        end
      when 15
        unless instance.r15_hash.blank?
          return instance.r15_hash
        else
          return "-"
        end
      when 16
        unless instance.r16_hash.blank?
          return instance.r16_hash
        else
          return "-"
        end
      when 17
        unless instance.r17_hash.blank?
          return instance.r17_hash
        else
          return "-"
        end
      when 18
        unless instance.r18_hash.blank?
          return instance.r18_hash
        else
          return "-"
        end
    end
  end


end
