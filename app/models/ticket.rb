class Ticket < ApplicationRecord
   has_many :employee_tickets
   has_many :employees, through: :employee_tickets

   def self.ordered_by_age
      order(age: :desc) 
   end

   def self.oldest
      order(age: :desc).first
   end
end 