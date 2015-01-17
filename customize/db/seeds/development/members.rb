# coding: utf-8
 
names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]
0.upto(9) do |idx|
  Member.create(
    login_id: "#{names[idx]}",
    password: "abc",
    name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    tel: "0123-45-6789",
    email: "#{names[idx]}@example.com",
    admin: (idx == 0)
  )
end
