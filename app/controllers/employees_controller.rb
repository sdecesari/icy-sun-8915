class EmployeesController < ApplicationController
   def show
      @employees = Employee.find(params[:id])     
   end

   def create
      @employee = Employee.find(params[:id])
      @ticket = Ticket.create(subject: params[:subject], age: params[:age])
      @employee.tickets << @ticket 
      redirect_to "/employees/#{@employee.id}"     
   end
end 