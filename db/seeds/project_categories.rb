puts 'Creating project categories'

project_categories = [
  'スマホ',
  'パソコン',
  '家電',
  '初期設定',
  'データ移行',
  '購入相談'
]

project_categories.each do |category|
  ProjectCategory.create!(
    name: category
  )
end

