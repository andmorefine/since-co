# frozen_string_literal: true

FactoryBot.define do
  factory :proverb do
    name { '頭隠して尻隠さず' }
    kana { 'あたまかくしてしりかくさず' }
    text { '欠点や悪事の一部だけを隠して全部隠したと思っていることを皮肉っていう。キジが草むらの中に首だけ突っ込んで尾が外に出ているのに気づかない様子からいわれる。' }
    image { 'AE21B67F-63A7-44B4-9CD6-7953ED3EF325.jpeg' }
    order { 1 }
    alphabetal_id { 1 }
    delete_flag { 0 }
  end
end
