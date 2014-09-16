def do_beiku words

	line1max = 1
	line2max = 3
	line3max = 5
	line3half = 2
	line4max = 3
	line5max = 1

	empty = "    "

	line1 = []
	line2 = []
	line3 = []
	line4 = []
	line5 = []

	words.each do |word|

			line5 << word if line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length == line4max and line5.length < line5max

			line4 << word if line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length < line4max

			line3 << word if line1.length == line1max and line2.length == line2max and line3.length > line3half and line3.length < line3max

			line3 << empty if line1.length == line1max and line2.length == line2max and line3.length ==line3half 

			line3 << word if line1.length == line1max and line2.length == line2max and line3.length < line3half 

			line2 << word if line1.length == line1max and line2.length < line2max 

			line1 << word if line1.length < line1max

			if  line1.length == line1max and line2.length == line2max and line3.length == line3max and line4.length == line4max and line5.length == line5max
			
				ap "        " + line1.join(" "), options = {:indent => 8}
				ap "    " + line2.join(" "), options = {:indent => 4}
				ap line3.join(" "), options = {:indent => 0}
				ap "    " + line4.join(" "), options = {:indent => 4}
				ap "        " + line5.join(" "), options = {:indent => 8}
				ap '    '

				line1 = []
				line2 = []
				line3 = []
				line4 = []
				line5 = []

			end
	end		
end

def do_haiku words
		line1max = 5
		line2max = 7
		line3max = 5

		line1 = []
		line2 = []
		line3 = []

		words.each do |word|

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
end

def do_offline words
	file = File.open(Rails.root + 'words.txt', 'w')
	file.puts(words)
	file.close
end

task mail_offline: :environment do


	require "awesome_print"
	require 'wordnet'

	file = File.open(Rails.root + 'words.txt', 'r')
	
	indices = [100,200,300,400]
	words = []

	indices.each do |i|
		word = 	file.gets.gsub("\n", "")
		words << word
		99.times {file.gets }
	end

	lex = WordNet::Lexicon.new

	words.each do |w|

		meaning = lex.lookup_synsets(w)
		
		p meaning[0].lexical_link(w)
		p '+++'
		p meaning
		p '-------'
		

	end
end

task offline_words: :environment do

	require "awesome_print"
	require 'wordnet'

	peppa_file = File.open(Rails.root + 'peppa.txt', 'r')
	adele_file = File.open(Rails.root + 'adele-sly.txt', 'r')

	peppa_words = peppa_file.readlines.to_s
	adele_words = adele_file.readlines.to_s.gsub(/[.,'-()!?’]/,"")

	counter = WordsCounted::Counter.new(adele_words)
	@count_hash = counter.word_density
	@count_hash.each do |w|
		p w 
	end
end

task mail: :environment do

      a = []
	  require 'HTTParty'
	  require 'Nokogiri'
	  require 'open-uri'
	  require 'date'
	  require "awesome_print"
	  require 'wordnet'

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


	######## OUTPUT as txt for offline
		#make_offline @clean	

	#######  BEIKU
		do_beiku @clean
	########  HAIKU
		do_haiku @clean
	

		# sense = WordNet::Sense.new

		# [@clean[0],@clean[100]].each do |w|

		# 	word_syn = sense.lookup_synsets( w, WordNet::Noun)



		# data = @s.split(" ").sort
		# hist = Hash[*data.group_by{ |v| v.downcase }.flat_map{ |k, v| [k, v.size] }].sort_by &:last
		
	end



