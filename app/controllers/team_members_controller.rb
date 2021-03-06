class TeamMembersController < ApplicationController
  before_action :set_team_member, only: [:show, :edit, :update, :destroy]
  #skip_before_filter  :verify_authenticity_token
  
  # GET /team_members
  # GET /team_members.json
  def index
    @team_members = TeamMember.all
  end
  
  def get_team_members
    @team = Team.find(params[:id])
    @team_members = []
    
    @team.team_members.each do |team_member|
      @user_c = {
        :id =>  team_member.id,
        :first_name => team_member.user.first_name,
        :last_name => team_member.user.last_name,
        :role =>  team_member.role 
      }
      @team_members.push(@user_c)
    end
  end

  # GET /team_members/1
  # GET /team_members/1.json
  def show
  end

  # GET /team_members/new
  def new
    @team_member = TeamMember.new
  end

  # GET /team_members/1/edit
  def edit
  end

  # POST /team_members
  # POST /team_members.json
  def create
    @team_member = TeamMember.new(team_member_params)

    respond_to do |format|
      if @team_member.save
        format.html { redirect_to @team_member, notice: 'Team member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_members/1
  # PATCH/PUT /team_members/1.json
  def update
    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to @team_member, notice: 'Team member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members/1
  # DELETE /team_members/1.json
  def destroy
    @team_member.destroy
    respond_to do |format|
      format.html { redirect_to team_members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_member
      @team_member = TeamMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_member_params
      params.require(:team_member).permit(:user_id, :team_id, :role)
    end
end
