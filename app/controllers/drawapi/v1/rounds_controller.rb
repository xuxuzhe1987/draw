class Drawapi::V1::RoundsController < Drawapi::V1::BaseController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :verify_request
  before_action :set_round, only: [ :show, :destroy ]

  def index
    @rounds = Round.where(user_id: @current_user.id).order(created_at: :desc)
  end

  def show
    @participants = @round.participants.all
  end

  def create
    @round = Round.new(round_params)
    content = @round.keyword + @round.target
    checking_res = message_check(content)
    if checking_res["errcode"] == 0
      @round.user = @current_user
      num_to_i = @round.num.to_i
      target_num = @round.target.to_i
      @round.arrayraw = (1..num_to_i).to_a
      @round.arraynew = (1..num_to_i).reject { |num| num == target_num }
      if @round.save
        render :show, status: :created
      else
        render_error
      end
    else
      render json: checking_res
    end
  end

  def destroy
    @round.destroy
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def round_params
    params.require(:round).permit(:num, :target, :keyword )
  end

  def render_error
    render json: { errors: @round.errors.full_messages },
    status: :unprocessable_entity
  end

end