class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url, only: [:show, :edit, :update, :destroy]
  # GET /shortened_urls
  # GET /shortened_urls.json
  def index
    @shortened_urls = ShortenedUrl.all
  end

  # GET /shortened_urls/1
  # GET /shortened_urls/1.json
  def show
  end

  # GET /shortened_urls/new
  def new
    @shortened_url = ShortenedUrl.new
  end

  # GET /shortened_urls/1/edit
  def edit
  end

  # POST /shortened_urls
  # POST /shortened_urls.json
  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)

    respond_to do |format|
      if @shortened_url.save
        format.html { redirect_to @shortened_url, notice: 'Shortened url was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @shortened_url }
      else
        format.html { render :new }
        format.js
        format.json { render json: @shortened_url.errors, status: :unprocessable_entity }
      end
    end
  end

def convert
#   shorten = UrlShortener::Client.shorten(params[:url]) 
   shorten = true
   if params[:url]
     @shortened_url = ShortenedUrl.where(url: params[:url]).first
   else
     @shortened_url = ShortenedUrl.where(unique_key: params[:key]).first
   end
   if !@shortened_url.present? and params[:url]
      shorten = UrlShortener::Client.shorten(params[:url])
      @shortened_url= ShortenedUrl.create(unique_key:  shorten,:url => params[:url])  if shorten    
   end
      @display_url =  shorten ? UrlShortener::Client.generate_shorten_url(@shortened_url.unique_key) : "Url already Short"
      @shortened_url.new_record? ? @display_url : "You will be redirected .."
   respond_to do |format|
        format.js
        format.html { redirect_to @shortened_url.url, notice: 'Shortened url was successfully created.' }
        format.json { render :show, status: :created, attr: @shortened_url,:shorten => @display_url }
    end
 
end

def expand
    original_url = ShortenedUrl.where(unique_key: params[:url]).first
    if original_url
       @display_url = original_url.url
   else
     @display_url = "No Match Found"
    end

    respond_to do |format|
        format.html { redirect_to  shortened_urls_path ,notice: 'Original url was successfully created.' }
        format.js
        format.json { render :show, status: :created,:original_url => original_url.url }
    end
end

def check_shorten_url
 
 end

  # PATCH/PUT /shortened_urls/1
  # PATCH/PUT /shortened_urls/1.json
  def update
    respond_to do |format|
      if @shortened_url.update(shortened_url_params)
        format.html { redirect_to @shortened_url, notice: 'Shortened url was successfully updated.' }
        format.json { render :show, status: :ok, location: @shortened_url }
      else
        format.html { render :edit }
        format.json { render json: @shortened_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shortened_urls/1
  # DELETE /shortened_urls/1.json
  def destroy
    @shortened_url.destroy
    respond_to do |format|
      format.html { redirect_to shortened_urls_url, notice: 'Shortened url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortened_url
      @shortened_url = ShortenedUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortened_url_params
      params[:shortened_url]
    end
end
