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

def random_date(year)
	month = 1 + rand(12)
	day = 1 + rand(28)
	"#{day}-#{month}-#{year}".to_date
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

# Find gem for random names
20.times do |n|
	unique_name = Faker::Name.unique.name
	unique_email = unique_name.split(" ").join + "@example.com"
	User.create(
		name: unique_name,
		email: unique_email,
		password: "password",
		birthdate: random_date(1993),
		admin: false,
		activated: true,
		activated_at: Time.now)
end

performer = Performer.create(name: "Drake")
performer_2 = Performer.create(name: "Eminem")
performer_3 = Performer.create(name:"Florence and the Machine")
performer_4 = Performer.create(name: "Flume")

more_performers = [
	"Tame Impala", 
	"Greta Van Fleet", 
	"Alison Wonderland", 
	"50 Cent",
	"Kanye West",
	"Jay-Z",
	"Calvin Harris",
	"Deadmau5",
	"Quix",
	"Big Gigantic",
	"Griz",
	"Gorgon City",
	"Kaskade",
	"Wuki",
	"Joey Bada$$",
	"Marshmello",
	"Shawn Mendes",
	"Nao",
	"Jorja Smith",
	"Skrillex"]

more_performers.each do |name|
	Performer.create(name: name)
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

manhattan_venues = [
	"Pianos",
	"Hulu Theater",
	"Playstation Theater",
	"Terminal 5",
	"Beacon Thearer",
	"Bowery Ballroom",
	"Bowery Electric",
	"Arlene's Grocery",
	"Pier 17",
	"Radio City Music Hall",
	"Apollo Theater",
	"Hammerstein Ballroom"]

boston_venues = [
	"TD Garden",
	"Paradise Rock Club",
	"Sinclair",
	"Middle East",
	"Agganis Arena",
	"Wonder Bar"]

manhattan_venues.each do |name|
	Venue.create(
		name: name,
		city: "New York",
		state: "NY")
end

boston_venues.each do |name|
	Venue.create(
		name: name,
		city: "Boston",
		state: "MA")
end


Performer.all.each do |p|
	Venue.all.each do |v|
		Event.create(
			performer: p,
			venue: v,
			date: random_date(2019)
			)
	end
end

ticketmaster = TransactionSource.create(name: "Ticketmaster")
stubhub = TransactionSource.create(name: "Stubhub")

more_sources = [
	"Tickpick",
	"Vivid Seats",
	"Ticekts Now",
	"The Ticketing Co",
	"Songkick",
	"SeatGeek",
	"Ticketfly",
	"AXS",
	"Ticketweb",
	"Sold Out Selection",
	"Ticket Pickers",
	"Facebook",
	"Craigslist",
	"Ebay",
	"Eventbrite",
	"Ticket Source",
	"Python Events",
	"Ticketbud",
	"Ticketleap"
]

more_sources.each do |name|
	TransactionSource.create(name: name)
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
		transaction_source: TransactionSource.all.sample,
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
		transaction_source: TransactionSource.all.sample,
		date: random_date(2018)
		)
end

# 12.times do |n|
# 	Transaction.create(
# 		event: Event.last,
# 		user: user,
# 		direction: "Purchase",
# 		quantity: 1,
# 		amount: 50,
# 		order_number: random_string(10),
# 		transaction_source: stubhub,
# 		date: random_date(2018),
# 		notes: "This is a note for this transaction"
# 		)
# end

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
