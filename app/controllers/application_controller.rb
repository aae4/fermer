class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'

protected
  def authorize_adm
	unless User.find_by_id(session[:user_id]) && (User.find_by_id(session[:user_id])).role=='admin'
		session[:original_uri]=request.env['REQUEST_URI']
		#flash[:notice] = "Please log in"
		#redirect_to :controller => 'admin', :action => 'login'

		respond_to do |format|
			flash[:notice]='Access Denied'
		        format.html { redirect_to root_path}
		end
	end
  end

  def auth
	unless User.find_by_id(session[:user_id])
		session[:original_uri]=request.env['REQUEST_URI']
		#flash[:notice] = "Please log in"
		#redirect_to :controller => 'admin', :action => 'login'

		respond_to do |format|
			flash[:notice]='Please Log In first'
		        format.html { redirect_to :controller => 'admin', :action => 'login'}
		end
	end
  end

  def non_auth
	unless !User.find_by_id(session[:user_id])
		flash[:notice]='You must be logged out for this action!'
	end
  end


end
