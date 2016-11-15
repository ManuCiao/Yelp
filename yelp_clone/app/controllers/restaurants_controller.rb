class RestaurantsController < ApplicationController
   def index
     @restaurants = Restaurant.all
   end

   def new 
   end
end
