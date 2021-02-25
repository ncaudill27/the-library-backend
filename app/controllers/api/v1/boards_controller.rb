module Api::V1
  class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]

    # GET /boards
    def index
      @boards = Board.all

      # options = { include: [:club, :comments] }
      render json: BoardSerializer.new(@boards)
    end

    # GET /boards/1
    def show
      render json: serialization
    end

    # POST /boards
    def create
      @board = Board.new(board_params)
      if @board.save && session_user
        render json: {thread: BoardSerializer.new(@board), userId: session_user.id, success: "Added #{@board.title}"}, status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /boards/1
    def update
      if @board.update(board_params)
        render json: serialization
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    end

    # DELETE /boards/1
    def destroy
      @board.destroy
      destroy_response(@board)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_board
        @board = Board.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def board_params
        params.require(:board).permit(:club_id, :title)
      end

      def serialization
        options = {
          include: [:comments, :clubs],
          links: {uri: request.base_url + "/boards/#{@board.id}"}
        }
        serialize(@board, options)
      end
  end
end