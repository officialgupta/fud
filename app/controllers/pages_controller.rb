class PagesController < ApplicationController
    def index
        
    end
    
    def show
       render "pages/#{params[:name]}" 
    end
end
