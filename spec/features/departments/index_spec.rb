require 'rails_helper'

RSpec.describe "Department Index Page" do
   it "can see the departments name and floor as well as the names of all employees" do 
      dept1 = Department.create!(name: "Human Resources", floor: "third")
      dept2 = Department.create!(name: "Sales", floor: "first")

      employee1 = Employee.create!(name: "Sam", level: 2, department_id: dept1.id)
      employee2 = Employee.create!(name: "Charlie", level: 4, department_id: dept1.id)
      employee3 = Employee.create!(name: "Alex", level: 1, department_id: dept2.id)
      employee4 = Employee.create!(name: "Ash", level: 3, department_id: dept2.id)

      visit "/departments"

      within "#department-#{dept1.id}" do 
         expect(page).to have_content("Name: Human Resources")
         expect(page).to have_content("Floor: third")
         expect(page).to have_content("Name: Charlie")
         expect(page).to_not have_content("Name: Sales")
         expect(page).to_not have_content("Floor: first")
      end 

      within "#department-#{dept2.id}" do 
         expect(page).to have_content("Name: Sales")
         expect(page).to have_content("Floor: first")
         expect(page).to have_content("Name: Alex")
         expect(page).to have_content("Level: 1")
         expect(page).to_not have_content("Name: Human Resources")
         expect(page).to_not have_content("Floor: third")
      end 
   end 
end 