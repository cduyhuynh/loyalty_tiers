# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
loyalty_tiers = [{name: 'bronze', condition: 0, rank: 0}, 
                {name: 'silver', condition: 10000, rank: 1}, 
                {name: 'gold', condition: 50000, rank: 2}]
LoyaltyTier.create(loyalty_tiers)