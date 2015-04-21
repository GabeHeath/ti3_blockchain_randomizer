class RandomizersController < ApplicationController
  before_action :set_randomizer, only: [:show, :edit, :update, :destroy]


  def index
    @randomizer = Randomizer.last
    @activities = PublicActivity::Activity.where(:trackable_id => Randomizer.last.id).order("created_at desc").limit(21)
    @clock = @randomizer.clock + 30.seconds
    @time = Time.parse( @clock.to_s ).to_i*1000

    current_block_hash = get_block_hash

    if @randomizer.last_block_hash == current_block_hash #Block hasn't changed
      @randomizer.create_activity :wait
    else                                                #Block has changed
      @randomizer.last_block_hash = current_block_hash
      randomize(@randomizer)
      @randomizer.create_activity :found
    end

    @randomizer.clock = @clock + 30.seconds
    @randomizer.save
  end


  def show
  end


  def new
    @randomizer = Randomizer.new
  end


  def edit
  end


  def create
    require 'digest'

    @randomizer = Randomizer.new(randomizer_params)

    temp_player_dir = "#{Rails.root}/rand_logs/tmp/tmp_player.txt"
    temp_race_dir = "#{Rails.root}/rand_logs/tmp/tmp_race.txt"
    players_file_dir = "#{Rails.root}/rand_logs/original_player_order_#{Time.now.to_s}.txt"
    races_file_dir = "#{Rails.root}/rand_logs/original_race_order_#{Time.now.to_s}.txt"

    File.write(players_file_dir, orig_player_file(randomizer_params))
    @randomizer.player_checksum = Digest::SHA256.hexdigest( File.read(players_file_dir) )

    File.write(races_file_dir, orig_race_file(randomizer_params))
    @randomizer.race_checksum = Digest::SHA256.hexdigest( File.read(races_file_dir) )

    File.write(temp_player_dir, orig_player_file(randomizer_params))
    File.write(temp_race_dir, orig_race_file(randomizer_params))

    @randomizer.player_counter = player_count(randomizer_params)
    @randomizer.race_counter = race_count(randomizer_params)

    @randomizer.last_block_hash = get_block_hash
    @randomizer.clock = Time.now



    respond_to do |format|
      if @randomizer.save
        @randomizer.create_activity :create
        format.html { redirect_to randomizers_path }
        format.json { render :show, status: :created, location: @randomizer }
      else
        format.html { render :new }
        format.json { render json: @randomizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /randomizers/1
  # PATCH/PUT /randomizers/1.json
  def update
    respond_to do |format|
      if @randomizer.update(randomizer_params)
        format.html { redirect_to @randomizer, notice: 'Randomizer was successfully updated.' }
        format.json { render :show, status: :ok, location: @randomizer }
      else
        format.html { render :edit }
        format.json { render json: @randomizer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /randomizers/1
  # DELETE /randomizers/1.json
  def destroy
    @randomizer.destroy
    respond_to do |format|
      format.html { redirect_to randomizers_url, notice: 'Randomizer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_randomizer
      @randomizer = Randomizer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def randomizer_params
      params.require(:randomizer).permit(:player_1, :player_2, :player_3, :player_4, :player_5, :player_6, :player_7, :player_8,
                                         :arborec, :barony, :yin, :saar, :muaat, :hacan, :sol, :creuss, :l1z1x,
                                         :mentak, :naalu, :nekro, :sardakk, :jolnar, :winnu, :xxcha, :yssaril, :lazax)
    end

    def orig_player_file(params)
      players = []

      unless params['player_1'].blank?
        players.push(params['player_1'])
      end

      unless params['player_2'].blank?
        players.push(params['player_2'])
      end

      unless params['player_3'].blank?
        players.push(params['player_3'])
      end

      unless params['player_4'].blank?
        players.push(params['player_4'])
      end

      unless params['player_5'].blank?
        players.push(params['player_5'])
      end

      unless params['player_6'].blank?
        players.push(params['player_6'])
      end

      unless params['player_7'].blank?
        players.push(params['player_7'])
      end

      unless params['player_8'].blank?
        players.push(params['player_8'])
      end

      return players.join("\n")
    end

    def orig_race_file(params)
      races = []

      unless params['arborec'] == "0"
        races.push('The Arborec')
      end

      unless params['barony'] == "0"
        races.push('The Barony of Letnev')
      end

      unless params['yin'] == "0"
        races.push('The Brotherhood of Yin')
      end

      unless params['saar'] == "0"
        races.push('The Clan of Saar')
      end

      unless params['muaat'] == "0"
        races.push('The Embers of Muaat')
      end

      unless params['hacan'] == "0"
        races.push('The Emirates of Hacan')
      end

      unless params['sol'] == "0"
        races.push('The Federation of Sol')
      end

      unless params['creuss'] == "0"
        races.push('The Ghosts of Creuss')
      end

      unless params['l1z1x'] == "0"
        races.push('The L1Z1X Mindnet')
      end

      unless params['mentak'] == "0"
        races.push('The Mentak Coalition ')
      end

      unless params['naalu'] == "0"
        races.push('The Naalu Collective')
      end

      unless params['nekro'] == "0"
        races.push('The Nekro Virus')
      end

      unless params['sardakk'] == "0"
        races.push("The Sardakk N'orr")
      end

      unless params['jolnar'] == "0"
        races.push('The Universities of Jol-Nar')
      end

      unless params['winnu'] == "0"
        races.push('The Winnu')
      end

      unless params['xxcha'] == "0"
        races.push('The Xxcha Kingdom')
      end

      unless params['yssaril'] == "0"
        races.push('The Yssaril Tribes')
      end

      unless params['lazax'] == "0"
        races.push('The Lazax')
      end


      return races.join("\n")
    end

  def get_block_hash
    require 'open-uri'
    require 'json'

    content = JSON.parse(open("https://blockchain.info/latestblock").read)
    return content["hash"]
  end

  def player_count(params)
    count = 0

    unless params['player_1'].blank?
      count = count + 1
    end

    unless params['player_2'].blank?
      count = count + 1
    end

    unless params['player_3'].blank?
      count = count + 1
    end

    unless params['player_4'].blank?
      count = count + 1
    end

    unless params['player_5'].blank?
      count = count + 1
    end

    unless params['player_6'].blank?
      count = count + 1
    end

    unless params['player_7'].blank?
      count = count + 1
    end

    unless params['player_8'].blank?
      count = count + 1
    end

    return count
  end

  def race_count(params)
    count = 0

    unless params['arborec'] == "0"
      count = count + 1
    end

    unless params['barony'] == "0"
      count = count + 1
    end

    unless params['yin'] == "0"
      count = count + 1
    end

    unless params['saar'] == "0"
      count = count + 1
    end

    unless params['muaat'] == "0"
      count = count + 1
    end

    unless params['hacan'] == "0"
      count = count + 1
    end

    unless params['sol'] == "0"
      count = count + 1
    end

    unless params['creuss'] == "0"
      count = count + 1
    end

    unless params['l1z1x'] == "0"
      count = count + 1
    end

    unless params['mentak'] == "0"
      count = count + 1
    end

    unless params['naalu'] == "0"
      count = count + 1
    end

    unless params['nekro'] == "0"
      count = count + 1
    end

    unless params['sardakk'] == "0"
      count = count + 1
    end

    unless params['jolnar'] == "0"
      count = count + 1
    end

    unless params['winnu'] == "0"
      count = count + 1
    end

    unless params['xxcha'] == "0"
      count = count + 1
    end

    unless params['yssaril'] == "0"
      count = count + 1
    end

    unless params['lazax'] == "0"
      count = count + 1
    end

    return count
  end

  def read_line_number(filename, match_num)
    found_line, _idx =
        File.enum_for(:foreach, filename).each_with_index.detect do |_cur_line, idx|
          cur_line_num = idx+1
          cur_line_num == match_num
        end
    found_line.chomp
  end

  def delete_lines_from_file(filename, line_num)
    line_arr = File.readlines(filename)
    line_arr.delete_at(line_num - 1)

    file = File.open(filename, "w") do |f|
      line_arr.each{|line| f.puts(line)}
    end
  end

  def get_remaining_players
    return %x{wc -l #{'/Users/gabeheath/repos/gabe/ti3_blockchain_randomizer/rand_logs/tmp/tmp_player.txt'}}.split.first.to_i
  end

  def get_remaining_races
    return %x{wc -l #{'/Users/gabeheath/repos/gabe/ti3_blockchain_randomizer/rand_logs/tmp/tmp_race.txt'}}.split.first.to_i
  end

  def randomize(instance)
    player_file = '/Users/gabeheath/repos/gabe/ti3_blockchain_randomizer/rand_logs/tmp/tmp_player.txt'
    race_file = '/Users/gabeheath/repos/gabe/ti3_blockchain_randomizer/rand_logs/tmp/tmp_race.txt'
    if get_remaining_players > 0
      player_index = ( (instance.last_block_hash).hex % get_remaining_players  ) + 1
    end

    if get_remaining_races > 0
      race_index = ( (instance.last_block_hash).hex % get_remaining_races  ) + 1
    end


    if instance.rand_p1.blank? && instance.player_counter >= 1
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p1 = player
      instance.p1_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p2.blank? && instance.player_counter >= 2
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p2 = player
      instance.p2_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p3.blank? && instance.player_counter >= 3
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p3 = player
      instance.p3_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p4.blank? && instance.player_counter >= 4
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p4 = player
      instance.p4_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p5.blank? && instance.player_counter >= 5
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p5 = player
      instance.p5_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p6.blank? && instance.player_counter >= 6
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p6 = player
      instance.p6_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p7.blank? && instance.player_counter >= 7
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p7 = player
      instance.p7_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_p8.blank? && instance.player_counter == 8
      player = read_line_number(player_file, player_index)
      delete_lines_from_file(player_file, player_index)

      instance.rand_p8 = player
      instance.p8_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r1.blank? && instance.race_counter >= 1
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r1 = race
      instance.r1_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r2.blank? && instance.race_counter >= 2
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r2 = race
      instance.r2_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r3.blank? && instance.race_counter >= 3
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r3 = race
      instance.r3_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r4.blank? && instance.race_counter >= 4
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r4 = race
      instance.r4_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r5.blank? && instance.race_counter >= 5
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r5 = race
      instance.r5_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r6.blank? && instance.race_counter >= 6
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r6 = race
      instance.r6_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r7.blank? && instance.race_counter >= 7
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r7 = race
      instance.r7_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r8.blank? && instance.race_counter >= 8
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r8 = race
      instance.r8_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r9.blank? && instance.race_counter >= 9
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r9 = race
      instance.r9_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r10.blank? && instance.race_counter >= 10
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r10 = race
      instance.r10_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r11.blank? && instance.race_counter >= 11
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r11 = race
      instance.r11_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r12.blank? && instance.race_counter >= 12
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r12 = race
      instance.r12_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r13.blank? && instance.race_counter >= 13
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r13 = race
      instance.r13_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r14.blank? && instance.race_counter >= 14
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r14 = race
      instance.r14_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r15.blank? && instance.race_counter >= 15
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r15 = race
      instance.r15_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r16.blank? && instance.race_counter >= 16
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r16 = race
      instance.r16_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r17.blank? && instance.race_counter >= 17
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r17 = race
      instance.r17_hash = instance.last_block_hash
      instance.save
    elsif instance.rand_r18.blank? && instance.race_counter >= 18
      race = read_line_number(race_file, race_index)
      delete_lines_from_file(race_file, race_index)

      instance.rand_r18 = race
      instance.r18_hash = instance.last_block_hash
      instance.save
    end
  end
end
