class VerificationsController < ApplicationController
	before_filter :log_user_by_verif

	def show
		check=(request.path.to_s.split("/"))[-1]
		if @user && @user.verif_code==check
			@user.verify
			flash[:notice]="It's all right! Now you can log in"
			redirect_to root_path
		end
	end

	def log_user_by_verif
		@user = User.find_by_verif_code(params[:id])
		flash[:notice] = "Account not found" unless @user
	end	
end
