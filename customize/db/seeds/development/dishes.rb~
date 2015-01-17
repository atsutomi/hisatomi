#coding : utf-8

names = ["白米", "ハンバーグ", "コーンサラダ", "五穀米", "唐揚げ", "海藻サラダ"]
genras = ["分類なし", "洋食", "分類なし", "日本食", "日本食", "分類なし"]
categories = ["主食", "主菜", "副菜"]
0.upto(30) do |idx|
  dish = Dish.create(
    name: names[idx%6],
    kcal: idx * 100 + 100,
    yen: idx * 100,
    genra: "#{genras[idx%6]}",
    category: "#{categories[idx%3]}"
  )

  fname = Rails.root.join("db/seeds/development", "dish#{idx%3+1}.jpeg")
  DishImage.create(
    dish: dish,
    data: File.open(fname, "rb").read,
    content_type: "image/jpeg"
  )

end
