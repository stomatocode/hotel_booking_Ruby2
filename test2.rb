hotels = {:lakewood=>
          {:name=>"Lakewood",
           :rating=>"3",
           :regular_weekday=>"110",
           :regular_weekend=>"90",
           :rewards_weekday=>"80",
           :rewards_weekend=>"80"},
         :bridgewood=>
          {:name=>"Bridgewood",
           :rating=>"4",
           :regular_weekday=>"160",
           :regular_weekend=>"60",
           :rewards_weekday=>"110",
           :rewards_weekend=>"50"},
         :ridgewood=>
          {:name=>"Ridgewood",
           :rating=>"5",
           :regular_weekday=>"220",
           :regular_weekend=>"150",
           :rewards_weekday=>"100",
           :rewards_weekend=>"40"},
         :hedgewood=>
          {:name=>"Hedgewood",
           :rating=>"6",
           :regular_weekday=>"300",
           :regular_weekend=>"200",
           :rewards_weekday=>"110",
           :rewards_weekend=>"80"}
         }


hotel1 = :bridgewood
hotel2 = :hedgewood

option1 = hotels[hotel1]
option2 = hotels[hotel2]

if option2[:rating] > option1[:rating]
  p option2[:name]
else
  p option1[:name]
end


ratings = {}
regular_weekend = {}
hotels.select {|key,value| ratings[key] = value[:rating]}
hotels.select {|key,value| regular_weekend[key] = value[:regular_weekend]}


p ratings.values.max
p regular_weekend.values.min 

# if ARGV.first != "reservations2_spec.rb"



<<-NOTES

notes:  when she replies, what would the next steps be for me, and how about long will it be before i hear anything? 
i'm looking at interviewing at other places and obviously TW is my top chioce, so it would be great to know how to plan out so i can prioritize TW


Hi Carolina,
I just wanted to let you know I had some bugs I needed to work out before handing this over.
Thanks for the extension on the time.
Just a pre warning I am pretty new to TDD so I want to set the expectation that I know my testing skills are a little weak
and need work
That being said I really enjoyed the challenge and found it a worthy advisory.
I did have some challenges with my environment and ended up figuring out those bugs.
I feel like I can refactor this forever but know that this is a good first swing.
Would you like my refactored code once I finish refactoring to compare to my original work?
If so let me know. I look forward to hearing back from you and hearing what your developers think of my work and where I can improve. I love great feedback.

NOTES 

