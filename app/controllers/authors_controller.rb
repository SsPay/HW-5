class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :correct_author, only: [:edit, :update, :destroy]

  def correct_author
      @authors = Author.find_by(id: params[:id])
      unless current_author
        redirect_to root_path(current_author)
      end
  end

  def index
    @authors = Author.all
  end

  # GET /authors/1
  # GET /authors/1.json

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to root_path, notice: 'author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to root_path, notice: 'author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_email
    author = Author.find_by_confirm_token(params[:id])
    if author
      author.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:login, :email, :password, :password_confirmation)
    end
end
