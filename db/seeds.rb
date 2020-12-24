
seed_tasks = [
  'db:seed:users',
  'db:seed:project_categories',
  'db:seed:prefectures',
  'db:seed:projects'
]

seed_tasks.each do |task|
  Rake::Task[task].invoke
end


