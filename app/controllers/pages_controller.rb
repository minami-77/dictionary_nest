class PagesController < ApplicationController
  def home
    render json: { message: "Hello DictionaryNest API!" }
  end
end
