class AttendancesController < ApplicationController
   before_action :set_attendance, only: %i[ show update destroy ]
   before_action :authenticate_user!, only: %i[create, destroy, update, show, index]
 
   # GET /meals
   def index
     @attendance = Attendance.all
 
     render json: @attendance
   end
 
   # GET /meals/1
   def show
     render json: @attendance
   end
 
   # POST /meals
   def create
      @attendance = Attendance.new(attendance_params)

      if @attendance.save
         render json: @attendance, status: :created, location: @attendance
      else
         render json: @attendance.errors, status: :unprocessable_entity
      end
   end
 
   # PATCH/PUT /meals/1
   def update
      @host = Meal.find(@attendance.meal_id).host
      if @host.id === current_user.id && @attendance.update(attendance_params)
         render json: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
   end
 
   # DELETE /meals/1
   def destroy
      @host = Meal.find(@attendance.meal_id).host
      @guest = User.find(@attendance.guest_id)
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
       params.require(:attendance).permit(:guest_id, :meal_id)
     end
 end