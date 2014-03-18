Ruby Reservations

I have really enjoyed working on this challenge, as it was interesting and
dynamic! I wrote it in Ruby 2.0.0, and rspec 2.14.7, as well as pry 0.9.12.6.
I chose to write this challenge in Ruby because I completed DBC with a focus 
on Ruby and. on of my biggest challenges was not being able to use the rails 
framework, especially when it came to ActiveRecord/ORM functions. I 
have so far had limited exposure to TDD in my time developing in Ruby.

##--

To run: 

1. Extract/unzip compressed folder into it's own directory and navigate to it
in the terminal
2. Open terminal and navigate to directory with unpacked files.
3. enter the ruby interpreter command [ruby] and the name of the file 
[ruby_reservations.rb](iuncluding the file extension '.rb')
4. Begin by specifying a customer type, [rewards] or [regular] (a set of 
instructions will appear above the prompt field)
5. Then specify dates in the [DayMonthYear](i.e. "22Mar2009) format, delmit
with spaces or commas and spaces
6. Press enter when finished entering dates (I have tested up to three dates 
at a time; in theory can accept more, but i didn't have time to test that far)
7. Script will output the name of the lowest cost hotel (or the in the event 
of a tie on lowest cost, the hotel with the highest rating), and then exit

##--

I chose to approach solving this problem with hashes because I wanted to 
maintain a way of looking up attributes of different objects in a specifc
fashion. I opted for a nested hash because I wanted to have a way of 
conceiving of the different hotels as complete objects that I could look up
with a symbolized key. I also was thinking of Rails and about how something
like this could be expanded on and reconfigured to work with an ORM like
ActiveRecord, which is also why I moved the file I/O to a module and gave
it a specific name, as well as the user input and main event execution. I'm a
junior programmer, still learning, and any feedback that can be shared on
these notes is greatly appreciated in the interest of continued learning! 
I plan to find ways to refactor and redesign some of the choices I made for 
that reason. 

##--

Testing:
Testing was focused on the main class and the operations it performs, as the 
modules were simple file-reading and terminal interface methods. In my experiene 
with TDD and rspec, focusing on testing units and individual methods was emphasized 
and I spent my time designing the functions to meet these testing ideas. 

To test:

1. Comment-out line 82 [Booking.run]
2. Return to terminal and run [rspec] command
3. Tests should all pass/be green

