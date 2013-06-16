class HomeController < ApplicationController
	def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @games }
    end
  end

  def add_to_list
		email = params[:email]

		h = Hominid::API.new('7f28b65048208c6ddea75375a3034eb6-us7')
    list = h.lists['data'].first
    h.list_subscribe(list['id'], email, {}, 'html', false, true, true, false)

    redirect_to('/')
  end
end