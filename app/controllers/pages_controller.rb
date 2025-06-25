class PagesController < ApplicationController
  def home
    render json: { message: "ようこそ DictionaryNest API!" }
  end
end
