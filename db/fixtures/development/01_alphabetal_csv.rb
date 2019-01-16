require 'csv'

csv = CSV.read('db/fixtures/alphabetals.csv')

csv.each do |line|
  id = line[0]
  name = line[1]

  MAlphabetal.seed(:id) do |s|
    s.id = id
    s.name = name
  end
end
