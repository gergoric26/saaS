class WikisController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, except: [:index, :show, :create, :new, :destroy]

  def index
    @wikis = Wiki.visible_to(current_user)
    #authorize Wiki
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Post was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:id])

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash[:error] = "There was an error deleting the wiki."
       render :show
     end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
