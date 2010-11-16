require 'builder'
class VibramController < ApplicationController
	respond_to :html, :xml
	
	def index
	end

	def convert

		inch = params[:inch]
		fraction = params[:fraction]
		gender = params[:gender]
		@res = do_conversion(inch,fraction,gender)		

		respond_to do |format|
			format.html
			#format.xml { render :xml => myh.to_xml } 
			format.xml
			format.json { render :json => [@res].to_json}
		end
	end
	
	def parse
	end
	
	def radians angle
		angle.to_f/180.0 * Math::PI
	end
	
	def coordinate_distance 
		coords = JSON.parse(params[:coords])
		@distance = dist(coords)
		respond_to do |format|
			format.xml
			format.json { render :json => [distance].to_json}
		end
	end

	def dist points
		nowLa = points[0][0]
		nowLo = points[0][1]
		radius = 6371
		dist = 0
		points.each do |p|
			distLa = radians (nowLa - p[0])
			distLo = radians (nowLo - p[1])
			s1 = Math.sin(distLa/2) * Math.sin(distLa/2) + Math.cos( radians( nowLa )) * Math.cos( radians ( p[0] ) ) * Math.sin(distLo/2) * Math.sin(distLo/2)
			s2 = 2 * Math.atan2( Math.sqrt(s1), Math.sqrt(1-s1) )
			newd = radius * s2
			dist = dist + newd
			nowLa = p[0]
			nowLo = p[1]	
		end
		dist			
	end
	
	def do_conversion inch, fraction, gender
		inch = inch.to_f
		fraction = fraction[0..1].to_f / 100.0
		inch = inch + fraction
		mens_inches = [9.75, 10.0, 10.25, 10.5, 10.75, 11.0, 11.25, 11.5, 11.75, 12.0, 12.25]
		womens_inches = [8.375, 8.625, 8.875, 9.125, 9.375, 9.625, 9.875, 10.125, 10.375]
		womens_euro = [34, 35, 36, 37, 38, 39, 40 , 41, 42] 
		mens_euro = [38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]
		if ((inch >= 9.75 && inch < 12.5) && gender == "male")
		  if mens_inches.include?(inch)
		    return mens_euro[mens_inches.index(inch)]
		  else
		    tempInch = inch * 4
		    tempInch = tempInch.round
		    inch = tempInch / 4
		    return mens_euro[mens_inches.index(inch)]
	    end
    elsif ((inch >= 8 && inch < 10.625) && gender == "female")
      if womens_inches.include?(inch)
        return womens_euro[womens_inches.index(inch)]
      else
        return womens_euro[womens_inches.index(womens_inches.sort_by{|x| (x-inch).abs}.first)]
      end
    else
      -1
    end
  end
			
end
