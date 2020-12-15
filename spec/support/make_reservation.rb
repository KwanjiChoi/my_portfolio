shared_examples 'make reservation' do
  let!(:requester)   { create(:user) }
  let!(:supplier)    { create(:user, teacher: true) }
  let!(:project)     { create(:project, user: supplier) }
  let!(:reservation) { create(:reservation, project: project, requester: requester) }
  let!(:room)        { create(:room, reservation: reservation) }

  let!(:other_user)  { create(:user) }
end
