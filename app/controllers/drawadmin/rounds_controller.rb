class Drawadmin::RoundsController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "xuxuzhe1987"
    before_action :set_round, only: [ :destroy ]

    def index
        @rounds = Round.order(created_at: :desc)
        @participants = Participant.order(created_at: :desc)
    end

    def destroy
        @round.destroy
        redirect_to drawadmin_rounds_path
    end

    private

    def set_round
        @round = Round.find(params[:id])
    end

end

