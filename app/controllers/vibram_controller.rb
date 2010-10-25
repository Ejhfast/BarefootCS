require 'builder'
class VibramController < ApplicationController
	respond_to :html, :xml
	
	def index
	end

	def convert

		inch = params[:inch]
		fraction = params[:fraction]
		@res = do_conversion(inch,fraction)		

		respond_to do |format|
			format.html
			#format.xml { render :xml => myh.to_xml } 
			format.xml
		end
	end
	
	def parse
	end
	
	def radians angle
		angle.to_f/180.0 * Math::PI
	end
	
	def coordinate_distance 
		coords = 
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
			s2 = 2 * Math.atan2( Math.sqrt(s1), Math.sqrt(1-a) )
			newd = radius * s2
			dist = dist + newd
			nowLa = p[0]
			nowLo = p[1]	
		end
		dist			
	end
	
	def do_conversion inch, fraction
		inch = inch.to_i
		fraction = fraction.to_f / 100
		inch = inch + fraction
		if inch >= 9.75 && inch < 10
			38
		elsif inch >= 10 && inch < 10.25
			39
		elsif inch >= 10.25 && inch < 10.5
			40
		elsif inch >= 10.5 && inch < 10.75
			41
		elsif inch >= 10.75 && inch < 11
			42
		elsif inch >= 11 && inch < 11.25
			43
		elsif inch >= 11.25 && inch < 11.5
			44
		elsif inch >= 11.5 && inch < 11.75
			45
		elsif inch >= 11.75 && inch < 12
			46
		elsif inch >= 12.00 && inch < 12.25
			47
		elsif inch >= 12.25 && inch < 12.5
			48
		else
			-1
		end
	end
end
