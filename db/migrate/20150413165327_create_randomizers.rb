class CreateRandomizers < ActiveRecord::Migration
  def change
    create_table :randomizers do |t|
      t.string :player_checksum
      t.string :race_checksum
      t.string :last_block_hash
      t.string :player_1, :null => false
      t.string :p1_hash
      t.string :player_2, :null => false
      t.string :p2_hash
      t.string :player_3
      t.string :p3_hash
      t.string :player_4
      t.string :p4_hash
      t.string :player_5
      t.string :p5_hash
      t.string :player_6
      t.string :p6_hash
      t.string :player_7
      t.string :p7_hash
      t.string :player_8
      t.string :p8_hash
      t.boolean :arborec, :default => 1
      t.string :r1_hash
      t.boolean :barony, :default => 1
      t.string :r2_hash
      t.boolean :yin, :default => 1
      t.string :r3_hash
      t.boolean :saar, :default => 1
      t.string :r4_hash
      t.boolean :muaat, :default => 1
      t.string :r5_hash
      t.boolean :hacan, :default => 1
      t.string :r6_hash
      t.boolean :sol, :default => 1
      t.string :r7_hash
      t.boolean :creuss, :default => 1
      t.string :r8_hash
      t.boolean :l1z1x, :default => 1
      t.string :r9_hash
      t.boolean :mentak, :default => 1
      t.string :r10_hash
      t.boolean :naalu, :default => 1
      t.string :r11_hash
      t.boolean :nekro, :default => 1
      t.string :r12_hash
      t.boolean :sardakk, :default => 1
      t.string :r13_hash
      t.boolean :jolnar, :default => 1
      t.string :r14_hash
      t.boolean :winnu, :default => 1
      t.string :r15_hash
      t.boolean :xxcha, :default => 1
      t.string :r16_hash
      t.boolean :yssaril, :default => 1
      t.string :r17_hash
      t.boolean :lazax, :default => 1
      t.string :r18_hash
      t.boolean :lazax_sub, :default => 1
      t.datetime :clock


      t.timestamps null: false
    end
  end
end
