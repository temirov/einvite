class CompetitionsController < ApplicationController
  before_filter :signed_in_user

  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = current_user.competitions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competitions }
    end
  end

  # GET /competitions/1
  # GET /competitions/1.json
  def show
    @competition = Competition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/new
  # GET /competitions/new.json
  def new
    @user = User.find(params[:user_id])
    @competition = @user.competitions.build
    # @competition = Competition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/1/edit
  def edit
    @competition = Competition.find(params[:id])
  end

  # POST /competitions
  # POST /competitions.json
  def create    
    @user = User.find(params[:user_id])
    @competition = @user.competitions.build(params[:competition])
    @competition.users << @user
    
    respond_to do |format|
      if @competition.save
        format.html { redirect_to @competition, notice: 'Competition was successfully created.' }
        # format.html { redirect_to :user_competition, notice: 'Competition was successfully created.' }
        # format.html { redirect_to user_competitions_path(@user), notice: 'Competition was successfully created.' }
        format.json { render json: @competition, status: :created, location: @competition }
      else
        format.html { render action: "new" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /competitions/1
  # PUT /competitions/1.json
  def update
    @competition = Competition.find(params[:id])

    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy

    respond_to do |format|
      # format.html { redirect_to competitions_url }
      format.html { redirect_to user_competitions_url(current_user) }
      format.json { head :no_content }
    end
  end
end
