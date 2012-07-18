class NotesController < ApplicationController
  
  before_filter :require_user, :only => [:new, :create, :update, :edit, :destroy]
  respond_to :html, :json, :js
  
  # GET /notes
  # GET /notes.json
  def index
    if params[:tag_name]
      # find posts by tag: /tags/tagname
      @notes = Tag.find_by_name(params[:tag_name]).notes.order("created_at DESC").page params[:page]
    else
      @notes = Note.page params[:page]
    end
    respond_with(@notes)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    respond_with(@note)
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new
    respond_with(@note)
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.build(params[:note])
    if @note.save
      flash[:notice] = 'Note was successfully created.'
    end
    respond_with(@note)
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:notice] = 'Note was successfully updated.'
    end
    respond_with(@note)
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    if @note.user == current_user
      @note.destroy
      flash[:notice] = 'Your note has been destroyed.'
    else
      flash[:notice] = 'This is not your note to destroy.'
    end
    respond_with(@note)
  end
  
  def get_url_meta
    # @meta = { 'animal' => 'badger', 'fruit' => 'banana' }
    @meta = scrape_url_meta(params[:url])
    respond_to do |format|
      format.json { render :json => @meta }
    end
  end
  
  private
  
  def scrape_url_meta(url)
    if(url)
      res = Net::HTTP.get_response(URI(url))
      if res.code == "200"
        doc = Nokogiri::HTML.parse(res.body)
        name = doc.search('title').first.text
        meta = { 'name' => name }
      else
        meta = { 'error' => 'Page Unreachable' }
      end
    else
      meta = { 'error' => 'No URL' }
    end
    return meta
  end
  
end
