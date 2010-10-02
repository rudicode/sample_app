# exercise 3
# added comment
person1 = { :first => "John", :last => "Smith" }
person2 = { :first => "Jane", :last => "Smith" }
person3 = { :first => "Tommy", :last => "Smith" }

params = { :father => person1 , :mother => person2 , :child => person3 }

puts "#{params[:father][:first]}"
puts "#{params[:mother][:last]}"

