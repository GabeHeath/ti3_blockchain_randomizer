json.array!(@randomizers) do |randomizer|
  json.extract! randomizer, :id
  json.url randomizer_url(randomizer, format: :json)
end
