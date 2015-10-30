namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    # [User, Customer].each(&:delete_all)


    make_users
    # make_brands
    # make_products
    # make_receipts
  end



  task populate_users: :environment do
    make_users
  end

  # task populate_statuses: :environment do
  #   make_statuses
  # end
end


# def make_statuses
#   Order.update_all("status_id = null")
#   Status.delete_all
#
#   Status.create!(name: 'Новый')
#   Status.create!(name: 'Подтвержден')
#   Status.create!(name: 'Отгружен')
#   Status.create!(name: 'Аннулирован')
# end


def make_users


  31.times do |n|
      email = Faker::Internet.email
      password = 'password'
      User.create!(
          name: Faker::Name.name,
          email: email,
          password: password,
          password_confirmation: password
      )
  end
end

