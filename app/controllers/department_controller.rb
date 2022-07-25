class DepartmentController < ApplicationController 
   def index
      dept = Department.all
   end
end 