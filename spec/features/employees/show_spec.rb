require 'rails_helper'

RSpec.describe "Employee Show Page" do
   it "shows the employee name and department" do 
      dept1 = Department.create!(name: "Human Resources", floor: "third")
      dept2 = Department.create!(name: "Sales", floor: "first")

      employee1 = Employee.create!(name: "Sam", level: 2, department_id: dept1.id)
      employee2 = Employee.create!(name: "Charlie", level: 4, department_id: dept1.id)
      employee3 = Employee.create!(name: "Alex", level: 1, department_id: dept2.id)
      employee4 = Employee.create!(name: "Ash", level: 3, department_id: dept2.id)

      visit "/employees/#{employee1.id}"

         expect(page).to have_content("Name: Sam")
         expect(page).to have_content("Department: Human Resources")
         expect(page).to_not have_content("Name: Charlie")
         expect(page).to_not have_content("Name: Alex")
         expect(page).to_not have_content("Department: Sales")
   end 

   it "shows a list of employee tickets from oldet to youngets" do 
      dept1 = Department.create!(name: "Human Resources", floor: "third")
      dept2 = Department.create!(name: "Sales", floor: "first")

      employee1 = Employee.create!(name: "Sam", level: 2, department_id: dept1.id)
      employee2 = Employee.create!(name: "Charlie", level: 4, department_id: dept1.id)
      employee3 = Employee.create!(name: "Alex", level: 1, department_id: dept2.id)
      employee4 = Employee.create!(name: "Ash", level: 3, department_id: dept2.id)

      ticket1 = Ticket.create!(subject: "printers broke", age: 5)
      ticket2 = Ticket.create!(subject: "need ice", age: 4)
      ticket3 = Ticket.create!(subject: "email down", age: 3)
      ticket4 = Ticket.create!(subject: "phones down", age: 2)

      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket1.id)
      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket2.id)
      EmployeeTicket.create!(employee_id: employee2.id, ticket_id: ticket3.id)
      EmployeeTicket.create!(employee_id: employee3.id, ticket_id: ticket4.id)

      visit "/employees/#{employee1.id}"

      expect(page).to have_content("Ticket: printers broke")
      expect(page).to have_content("Ticket: need ice")
      expect(page).to_not have_content("Ticket: email down")
   end 

   it "does not show tickets that are not assigned to the employee" do 
      dept1 = Department.create!(name: "Human Resources", floor: "third")
      dept2 = Department.create!(name: "Sales", floor: "first")

      employee1 = Employee.create!(name: "Sam", level: 2, department_id: dept1.id)
      employee2 = Employee.create!(name: "Charlie", level: 4, department_id: dept1.id)
      employee3 = Employee.create!(name: "Alex", level: 1, department_id: dept2.id)
      employee4 = Employee.create!(name: "Ash", level: 3, department_id: dept2.id)

      ticket1 = Ticket.create!(subject: "printers broke", age: 5)
      ticket2 = Ticket.create!(subject: "need ice", age: 4)
      ticket3 = Ticket.create!(subject: "email down", age: 3)
      ticket4 = Ticket.create!(subject: "phones down", age: 2)

      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket1.id)
      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket2.id)
      EmployeeTicket.create!(employee_id: employee2.id, ticket_id: ticket3.id)
      EmployeeTicket.create!(employee_id: employee3.id, ticket_id: ticket4.id)

      visit "/employees/#{employee1.id}"

      expect(page).to have_content("printers broke")
      expect(page).to have_content("need ice")
      expect(page).to_not have_content("email down")
   end 

   it "can create a new tickets" do 
      dept1 = Department.create!(name: "Human Resources", floor: "third")
      dept2 = Department.create!(name: "Sales", floor: "first")

      employee1 = Employee.create!(name: "Sam", level: 2, department_id: dept1.id)
      employee2 = Employee.create!(name: "Charlie", level: 4, department_id: dept1.id)
      employee3 = Employee.create!(name: "Alex", level: 1, department_id: dept2.id)
      employee4 = Employee.create!(name: "Ash", level: 3, department_id: dept2.id)

      ticket1 = Ticket.create!(subject: "printers broke", age: 5)
      ticket2 = Ticket.create!(subject: "need ice", age: 4)
      ticket3 = Ticket.create!(subject: "email down", age: 3)
      ticket4 = Ticket.create!(subject: "phones down", age: 2)

      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket1.id)
      EmployeeTicket.create!(employee_id: employee1.id, ticket_id: ticket2.id)
      EmployeeTicket.create!(employee_id: employee2.id, ticket_id: ticket3.id)
      EmployeeTicket.create!(employee_id: employee3.id, ticket_id: ticket4.id)

      visit "/employees/#{employee1.id}"

      fill_in 'subject', with: "phones down"
      fill_in 'age', with: "2"
      click_on "Submit"

      expect(current_path).to eq("/employees/#{employee1.id}")
      expect(page).to have_content("phones down")
   end 
end 