# coding: utf-8

names = ["白米", "ハンバーグ", "コーンサラダ", "五穀米", "唐揚げ", "海藻サラダ", "チャーハン", "揚げ餃子", "漬物", "たけのこご飯", "春巻き", "マカロニサラダ", "五目ご飯", "鯖の味噌煮", "ポテトサラダ", "ミートソースパスタ", "照り焼きチキン", "ひじき"]

names.each do |name|
  dish = Dish.find_by_name(name)
    0.upto(60) do |idx|
    Stock.create(
    { dish: dish,
      date: idx.days.from_now.to_date,
      stock: 100
    }, without_protection: true)
  end
end
