require 'open-uri'

class VideosController < ApplicationController
	def index
		@videos = Video.all
	end

	def new
	end

	def search
		search = params[:video]
		url = "http://youtube.com/results?search_query=#{search}"
		html = Nokogiri::HTML(open(url))
		lis = html.css('#search-results li')
		lis[0..10].each do |li|
			url = li.get_attribute('data-context-item-id')
			title = li.get_attribute('data-context-item-views')
			# views = li.get_attribute('data-context-item-title')
			Video.create(:title => title, :url => url)
		end
		#binding.pry
		redirect_to(videos_path)
	end
end