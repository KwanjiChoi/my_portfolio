puts 'Creating project categories'

project_categories = [
  'スマホ',
  'パソコン',
  '家電',
  'スキル'
]

project_categories.each do |category|
  ProjectCategory.create!(
    name: category
  )
end

