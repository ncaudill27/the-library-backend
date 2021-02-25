module Api::V1
  class ClubsController < ApplicationController
    before_action :set_club, only: [:show, :update, :destroy]

    # GET /clubs
    def index
      @clubs = Club.all

      options = { meta: { total: @clubs.length } }
      render json: ClubSerializer.new(@clubs, options)
    end

    # GET /clubs/1
    def show
      render json: serialize(@club)
    end

    # POST /clubs
    def create
      @club = Club.new(club_params)
      
      if @club.save
        @membership = Membership.new(club_id: @club.id, user_id: session_user.id, mod: true)

        if @membership.save
          membership = {
            id: @membership.id.to_s,
            clubId: @membership.club_id.to_s,
            userId: @membership.user_id.to_s,
            isMod: @membership.mod
          }
          render json: {club: serialize(@club), membership: membership, success: "Created #{@club.name}"}, status: :created

        else
          render status: :unauthorized
        end
      else
        puts @club.errors.full_messages
        puts @membership.errors.full_messages
        render json: {errors: @club.errors}, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /clubs/1
    def update
      if @club.update(club_params)
        render json: serialize(@club)
      else
        render json: @club.errors, status: :unprocessable_entity
      end
    end

    # DELETE /clubs/1
    def destroy
      @club.destroy
      destroy_response(@club)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def club_params
      params.require(:club).permit(:name, :description, :avatar, :active_book_isbn13)
    end
  end
end