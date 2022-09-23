class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create, destroy, update, show, index]
 
   # GET /attendances
   def index
     @attendance = Attendance.all
     
 
     render json: @attendance
   end
 
   # GET /attendances/1
   def show
     render json: @attendance
   end
 
   # POST /attendances
   def create

         puts "*" * 100
         puts attendance_params
         puts "*" * 100


      @attendance = Attendance.new(attendance_params)
      @attendance.user = current_user



      if @attendance.save
         render json: @attendance, status: :created, location: @attendance
      else
         render json: @attendance.errors, status: :unprocessable_entity
      end
   end
 
   # PATCH/PUT /attendances/1
   def update
      @host = Meal.find(@attendance.meal_id).host
      if @host.id === current_user.id && @attendance.update(attendance_params)
         render json: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
   end
 
   # DELETE /attendances/1
   def destroy
      @host = Meal.find(@attendance.meal_id).host
      @guest = User.find(@attendance.user_id)
      # Attendance.where(meal_id: @attendance.meal_id).find_by(guest_id: @attendance.guest_id)
      # puts "*"*100
      # puts @attendance.meal_id
      # # puts @host 
      # puts "*"*100
      if (@host.id === current_user.id || @guest.id === current_user.id)
         @attendance.destroy
       else
         render json: @attendance.errors, status: :unprocessable_entity
       end
   end
 
   private
     # Use callbacks to share common setup or constraints between actions.
     def set_attendance
       @attendance = Attendance.find(params[:id])
     end
 
     # Only allow a list of trusted parameters through.
     def attendance_params
       params.require(:attendance).permit(:user_id, :meal_id)
     end

     private
     
     def is_owner?(requester)
      return requester.id === current_user_id ? true : false 
     end
 end