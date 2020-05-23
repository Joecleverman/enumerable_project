require_relative 'enumerable_methods.rb'

class Array
  prepend Enumerable
end

# my_each
puts 'Test for #my_each'
%w[Sally Marchony Bill].my_each { |e| print e, ' -- ' }
puts


# my_each_with_index
puts 'Test for #my_each_with_index'
hash = {}
%w[Jean dog Etienne].my_each_with_index { |element, index| hash[element] = index }
print hash
puts
(1..5).my_each_with_index { |element, index| puts "#{element} => #{index}" }
puts
[1, 2, 3, 4, 5].my_each_with_index { |element, index| puts "#{element} => #{index}" }
puts


# my_select
puts 'Test for #my_select'
print([2, 1, 6, 7, 4, 8, 10].my_select(&:even?))
puts



