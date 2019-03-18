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

venue = Venue.create(
		      name: "Madison Square Garden",
		      city: "New York",
		      state: "NY"
		    )

event = Event.create(
		      performer_id: performer.id,
		      venue_id: venue.id,
		      date: Date.today + 1.year
		    )

purchase = Transaction.create(
				      event_id: event.id,
				      user_id: user.id,
				      direction: "purchase",
				      amount: 99.99,
				      quantity: 2,
				      order_number: "1234567",
				      source: "Ticketmaster"
				    )

sale = Transaction.create(
	      event_id: event.id,
	      user_id: user.id,
	      direction: "sale",
	      amount: 69.99,
	      quantity: 1,
	      order_number: "1234567",
	      source: "Stubhub"
	    )
