class HomeController < ApplicationController
	before_filter :auth, :except => [:index]

	def index
	end
end
