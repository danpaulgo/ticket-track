# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_string(length)
	(0...length).map { ('A'..'Z').to_a[rand(26)] }.join
end

user = User.create(
	      name: "John Doe",
	      email: "user@example.com",
	      password: "password",
	      password_confirmation: "password",
	      birthdate: "2000-12-31",
	      activated: true,
	      activated_at: Time.now
	     )

admin = User.create(
					name: "Daniel Goldberg",
		      email: "admin@example.com",
		      password: "password",
		      birthdate: "1993-06-18",
		      admin: true,
		      activated: true,
		      activated_at: Time.now
				)

20.times do |n|
	User.create(
		name: "User #{n+3}",
		email:"example#{n+3}",
		password: "password",
		birthdate: "1999-12-31",
		admin: false,
		activated: true,
		activated_at: Time.now)
end

performer = Performer.create(name: "Drake")
performer_2 = Performer.create(name: "Eminem")
performer_3 = Performer.create(name:"Florence and the Machine")
performer_4 = Performer.create(name: "Flume")
20.times do 
	Performer.create(name: random_string(8))
end

venue = Venue.create(
		      name: "Madison Square Garden",
		      city: "New York",
		      state: "NY"
		    )

venue_2 = Venue.create(
			      name: "EchoStage",
			      city: "Washington",
			      state: "D.C."
			    )

venue_3 = Venue.create(
			      name: "Red Rocks",
			      city: "Morrison",
			      state: "CO"
			    )

venue_4 = Venue.create(
						name: "House of Blues",
						city: "Boston",
						state: "MA"
					)

20.times do
	Venue.create(
		name: random_string(8),
		city: "New York",
		state: "New York")
end

# def time_rand(from = 0.0, to = Time.now)
#   Time.at(from + rand * (to - from))
# end

def random_date(year)
	month = 1 + rand(12)
	day = 1 + rand(28)
	"#{day}-#{month}-#{year}".to_date
end


Performer.all.each do |p|
	Venue.all.each do |v|
		Event.create(
			performer: p,
			venue: v,
			date: random_date(2020)
			)
	end
end

ticketmaster = TransactionSource.create(name: "Ticketmaster")
stubhub = TransactionSource.create(name: "Stubhub")
20.times do 
	TransactionSource.create(name: random_string(6))
end
purchase_date = "21-04-2019".to_date
sale_date = "01-05-2019".to_date

Event.all.each do |e|
	q = rand(8) + 1
	pa = rand(10.0..99.99)
	Transaction.create(
		event: e,
		user: user,
		direction: "purchase",
		quantity: q, 
		amount: q*pa,
		order_number: random_string(10),
		transaction_source: ticketmaster,
		date: random_date(2018)
		)
	sa = rand(10.0..99.99)
	Transaction.create(
		event: e,
		user: user,
		direction: "sale",
		quantity: q, 
		amount: q*sa,
		order_number: random_string(10),
		transaction_source: stubhub,
		date: random_date(2018)
		)
end

12.times do |n|
	Transaction.create(
		event: Event.last,
		user: user,
		direction: "Purchase",
		quantity: 1,
		amount: 50,
		order_number: random_string(10),
		transaction_source: stubhub,
		date: random_date(2018),
		notes: "This is a note for this transaction"
		)
end

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "purchase",
	quantity: 4,
	amount: 200,
	order_number: random_string(10),
	transaction_source: ticketmaster,
	date: purchase_date
	)

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "sale",
	quantity: 3,
	amount: 210,
	order_number: random_string(10),
	transaction_source: stubhub,
	date: sale_date
	)

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "sale",
	quantity: 1,
	amount: 40.0,
	order_number: random_string(10),
	transaction_source: ticketmaster,
	date: sale_date
	)

Transaction.create(
	event: Event.last,
	user: admin,
	direction: "Purchase",
	quantity: 3,
	amount: 121.55,
	order_number: random_string(10),
	transaction_source: stubhub,
	date: purchase_date
	)

Transaction.create(
	event: Event.last,
	user: admin,
	direction: "Sale",
	quantity: 1,
	amount: 52.81,
	order_number: random_string(10),
	transaction_source: stubhub,
	date: sale_date
	)
