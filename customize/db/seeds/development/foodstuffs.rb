# coding: utf-8

names = %w(えび たこ いか かに くらげ 鶏肉 牛肉 豚肉)
0.upto(7) do |idx|
  foodstuff = Foodstuff.create(
    name: "#{names[idx]}"
  )
end
