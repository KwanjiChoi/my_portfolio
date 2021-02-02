projects = Project.limit(5)

project.each do |project|
  project.reservation.create!(

  )
end