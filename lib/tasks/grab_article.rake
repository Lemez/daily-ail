
task mail: :environment do

      a = []
	  require 'HTTParty'
	  require 'Nokogiri'
	  require 'open-uri'
	  require 'date'
	  require "awesome_print"

		response = open('http://www.dailymail.co.uk/home/index.html')
		doc = Nokogiri::HTML(response)

		words = ['the', 'breast', 'sex', 'naked', 'naughty', 'terror', 'horror', 'nightmare', 'afraid', "animal", 'money', 'benefits', 'immigrant', 'shop', 'attack', 'rape', 'vile', 'soldier', 'hero', 'star']
		tests = ['t', 'e', 'r', 'o', 'terror']

		i = 0
		tot = 0
		doc.css('div.articletext').each do |link|
	
			i += 1
			b = link.content.gsub("\n","").gsub("\t","").strip
			l = b.split(" ").length
			# p i.to_s + "(" + l.to_s + ") : " + b 

			tot += l

			a << b

		end

		p tot
		
		@s = a.join(" ").gsub(/[.,'-()!?’]/,"")
		# p @s
		
		

		counter = WordsCounted::Counter.new(@s)


		@count_hash = counter.word_density
		@clean = []
		@count_hash[0..500].each{|v| @clean << v[0]}


#######  BEIKU

		# line1max = 1
		# line2max = 3
		# line3max = 5
		# line3half = 2
		# line4max = 3
		# line5max = 1

		# empty = "    "

		# line1 = []
		# line2 = []
		# line3 = []
		# line4 = []
		# line5 = []

		# @clean.each do |word|

		# 	line5 << word if line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length == line4max and line5.length < line5max

		# 	line4 << word if line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length < line4max

		# 	line3 << word if line1.length == line1max and line2.length == line2max and line3.length > line3half and line3.length < line3max

		# 	line3 << empty if line1.length == line1max and line2.length == line2max and line3.length ==line3half 

		# 	line3 << word if line1.length == line1max and line2.length == line2max and line3.length < line3half 

		# 	line2 << word if line1.length == line1max and line2.length < line2max 

		# 	line1 << word if line1.length < line1max

		# 	if  line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length == line4max and line5.length == line5max
			
		# 		ap "        " + line1.join(" "), options = {:indent => 8}
		# 		ap "    " + line2.join(" "), options = {:indent => 4}
		# 		ap line3.join(" "), options = {:indent => 0}
		# 		ap "    " + line4.join(" "), options = {:indent => 4}
		# 		ap "        " + line5.join(" "), options = {:indent => 8}
		# 		ap '    '

		# 		line1 = []
		# 		line2 = []
		# 		line3 = []
		# 		line4 = []
		# 		line5 = []

		# 	end
		# end

########  HAIKU

		line1max = 5
		line2max = 7
		line3max = 5

		line1 = []
		line2 = []
		line3 = []

		@clean.each do |word|

			line3 << word if line1.length == line1max and line2.length == line2max and line3.length < line3max

			line2 << word if line1.length == line1max and line2.length < line2max 

			line1 << word if line1.length < line1max

			if  line1.length == line1max and line2.length == line2max and line3.length == line3max 
			
				p line1.join(" ")
				p line2.join(" ")
				p line3.join(" ")
			
				p '    '

				line1 = []
				line2 = []
				line3 = []
			

			end
		end


		# p tests.each {|word| p word + ": " + @s.count(word).to_s}
		# p @s.class
		# p @s.length

		# data = @s.split(" ").sort
		# hist = Hash[*data.group_by{ |v| v.downcase }.flat_map{ |k, v| [k, v.size] }].sort_by &:last

		# p hist
		
	end

