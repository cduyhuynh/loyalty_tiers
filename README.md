# README

## Introduction
This is a web app for e-commerce loyalty tiers
## Prerequisites:
List required software and tools, along with their appropriate versions.
```
Ruby 3.2.2
Rails 7.0
NodeJs 18.10.6
Yarn 3.6
ReactJs 18.2
Ubuntu 20.04
```

## Installation & Configuration
1. Cloning repository
```bash
git clone git@github.com:cduyhuynh/loyalty_tiers.git
```
2. Go to app directory and build docker container
```bash
docker-compose up
```
3. After docker started, access to docker
```bash
docker exec -it loyalty bash
```
4. Install packages
```bash
yarn install
```
## Database Setup
1. Access docker container
```bash
docker exec -it loyalty bash
```
2. Init Database
```bash
bundle exec rake db:create
```
3. Run migrations & seed
```bash
bundle exec rake db:migrate
bundle exec rake db:seed
```
## Running the Application
1. Start the development server
```
docker-compose up
```
2. Access docker and start webpack dev server
```
./bin/webpack-dev-server
```
3. Access application on web browser
```
http://localhost:3000
```
#### Run the test suite if needed
```
rails test test/
```
## Usage
#### Complete an order
* `PUT /api/orders/:id/complete`
#### Recalculate users tier annually
* Scheduling CalculateUserLoyaltyTierAnnuallyJob job to run at the first day of every year
#### User info endpoint
* `/users/:id`
#### User orders endpoint
* `/users/:id/orders`

## Special use cases
1. If a customer completes an order with high amount, their tier can jump more than 1 rank. For example: bronze -> gold
2. If a customer doesn't complete any orders within last year, recalculating tier job can downgrade their tier to base tier (bronze).

## Improvement
1. Instead of recalculating user's orders everytime customer completes an order, we can create a table only for storing user and their spending number from last year. We can clear this table at the first day of every year.
