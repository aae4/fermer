class ResetPasswordsController < ApplicationController
	before_filter :non_auth
	before_filter :log_user_by_verif, :only => [ :edit, :update ]

	def new
	end

	def create
		@user = User.find_by_email(params[:email])
		if @user
			@user.create_verif_code
			UserMailer.sent_password_reset_mail(@user).deliver
			flash[:notice]='Instructions to reset password have been sent.'
			redirect_to root_path
		else
			flash[:notice]='User with such email was not found in our database. Please check out and try again.'
			#redirect_to root_path
		end
	end

	def edit
	end

	def update
		check=(request.path.to_s.split("/"))[-1]
		#flash[:notice]='Something is wrong'
		if @user && @user.verif_code==check
			@user.password=params[:password]
			@user.password_confirmation=params[:password_confirmation]
			if @user.save
				flash[:success] = "Password was successfully updated. Now you can login with new_password."
				#redirect_to root_path
				#format.html { render action: "edit" }
			else
			       flash[:notice]='Something is wrong'
				@user.errors.add(:name, "wasn't filled in")
			       format.html { render action: "edit" }
			       #redirect_to root_path
			end
		end
	end

	def log_user_by_verif
		@user = User.find_by_verif_code(params[:id])
		flash[:notice] = "Account not found" unless @user
	end
end
