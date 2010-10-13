class VibramController < ApplicationController
	def index
		inch = params[:inch]
		fraction = params[:fraction]
		myh = Hash.new
		myh["inches"] = do_conversion(inch,fraction)		

		respond_to do |format|
			format.html 
			format.xml { render :xml => myh.to_xml } 
		end
	end
	
	def parse
          render => :part
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
			"not a valid value"
		end
	end
end
