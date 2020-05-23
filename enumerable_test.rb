require_relative 'enumerable_methods.rb'

class Array
  prepend Enumerable
end

# my_each
puts 'Test for #my_each'
%w[Sally Marchony Bill].my_each { |x| print x, ' -- ' }
puts



