#coding : utf-8

names = ["白米", "ハンバーグ", "コーンサラダ", "五穀米", "唐揚げ", "海藻サラダ", "チャーハン", "揚げ餃子", "漬物", "たけのこご飯", "春巻き", "マカロニサラダ", "五目ご飯", "鯖の味噌煮", "ポテトサラダ", "ミートソースパスタ", "照り焼きチキン", "ひじき"]
genras = ["分類なし", "洋食", "分類なし", "日本食", "日本食", "分類なし", "中華", "中華", "日本食", "日本食", "中華", "分類なし", "日本食", "日本食", "分類なし", "洋食", "日本食", "日本食"]
categories = ["staple", "main", "sub"]
cals = [360, 230, 120, 400, 250, 100, 450, 250, 150, 380, 250, 200, 380, 300, 200, 300, 300, 100]
values = [100, 200, 100, 120, 150, 100, 150, 200, 100, 150, 180, 100, 150, 180, 100, 150, 200, 100]
foodstuffsid = [1,2,3,4,5,6,7,8]
1.upto(18) do |idx|
  dish = Dish.create(
    name: names[idx-1],
    kcal: cals[idx-1],
    yen: values[idx-1],
    genra: "#{genras[idx-1]}",
    category: "#{categories[(idx+2)%3]}"
  )

  fname = Rails.root.join("db/seeds/development", "dish#{idx}.jpeg")
  DishImage.create(
    dish: dish,
    data: File.open(fname, "rb").read,
    content_type: "image/jpeg"
  )

  0.upto(1) do
    foodstuffs = Foodstuff.find(foodstuffsid[rand(foodstuffsid.length)])
    foodstuffs.dishes << dish
  end
end
