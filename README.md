# oystercard

Oystercard is based on the public transport payment system in London of touching in and out of stations using a card in order to pay for transport in a convinent way. 
Each card has a history of which stations it has been touched in and out at and it holds a balance which is deducted from with each journey. 
Each card will be initialized with a balance of 0 and can be topped up by users in order to use, if the balance is too low, the users travel will be declined.

This version of Oystercard is written in Ruby and tested using rspec.

To install:

  - Clone the repo
  - Run bundle install from the command line
  - To see tests run rspec
  - To utilize app open either pry or irb
