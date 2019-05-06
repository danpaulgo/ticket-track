# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
	      name: "John Doe",
	      email: "johndoe2000@gmail.com",
	      password: "password",
	      password_confirmation: "password",
	      birthdate: "2000-12-31"
	     )

admin = User.create(
					name: "Daniel Goldberg",
		      email: "danpaulgo@aol.com",
		      password: "password",
		      birthdate: "1993-06-18",
		      admin: true
				)

performer = Performer.create(name: "Drake")
performer_2 = Performer.create(name: "Eminem")
performer_3 = Performer.create(name:"Florence and the Machine")
performer_4 = Performer.create(name: "Flume")

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

Event.all.each do |e|
	q = rand(8) + 1
	pa = rand(10.0..99.99)
	Transaction.create(
		event: e,
		user: user,
		direction: "purchase",
		quantity: q, 
		amount: q*pa,
		order_number: (0...10).map { ('A'..'Z').to_a[rand(26)] }.join,
		transaction_source: ticketmaster
		)
	sa = rand(10.0..99.99)
	Transaction.create(
		event: e,
		user: user,
		direction: "sale",
		quantity: q, 
		amount: q*sa,
		order_number: (0...10).map { ('A'..'Z').to_a[rand(26)] }.join,
		transaction_source: stubhub
		)
end

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "purchase",
	quantity: 4,
	amount: 200,
	order_number: "1a",
	transaction_source: ticketmaster
	)

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "sale",
	quantity: 3,
	amount: 210,
	order_number: "1b",
	transaction_source: stubhub
	)

Transaction.create(
	event: Event.first,
	user: admin,
	direction: "sale",
	quantity: 1,
	amount: 40.0,
	order_number: "1c",
	transaction_source: ticketmaster
	)

Transaction.create(
	event: Event.last,
	user: admin,
	direction: "Purchase",
	quantity: 3,
	amount: 121.55,
	order_number: "2a",
	transaction_source: stubhub
	)

Transaction.create(
	event: Event.last,
	user: admin,
	direction: "Sale",
	quantity: 1,
	amount: 52.81,
	order_number: "1b",
	transaction_source: stubhub
	)




# event = Event.create(
# 		      performer_id: performer.id,
# 		      venue_id: venue.id,
# 		      date: Date.today + 1.year
# 		    )

# purchase = Transaction.create(
# 				      event_id: event.id,
# 				      user_id: user.id,
# 				      direction: "purchase",
# 				      amount: 99.99,
# 				      quantity: 2,
# 				      order_number: "1234567",
# 				      transaction_source: TransactionSource.create(name: "Ticketmaster")
# 				    )

# sale = Transaction.create(
# 	      event_id: event.id,
# 	      user_id: user.id,
# 	      direction: "sale",
# 	      amount: 69.99,
# 	      quantity: 1,
# 	      order_number: "1234567",
# 	      transaction_source: TransactionSource.create(name: "Stubhub")
# 	    )
