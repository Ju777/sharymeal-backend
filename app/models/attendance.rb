class Attendance < ApplicationRecord
   belongs_to :guest, class_name: "User" 
   belongs_to :meal
   
end