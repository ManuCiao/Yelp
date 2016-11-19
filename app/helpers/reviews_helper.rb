module ReviewsHelper
   def star_rating(rating)
     # does the rating respond to `round`? If not, just return the rating
     return rating unless rating.respond_to?(:round)

     # if it does – i.e. if it's a valid number - then the rest of the
     # method is run
     remainder = (5 - rating.round)
     "★" * rating.round + "☆" * remainder
   end
 end
