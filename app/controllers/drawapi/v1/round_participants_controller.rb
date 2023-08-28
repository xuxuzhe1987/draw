class Drawapi::V1::RoundParticipantsController < Drawapi::V1::BaseController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :verify_request, only: [ :show ]
  before_action :set_participant, only: [ :show, :update ]

  def index
    @participants = Participant.all
  end

  def show
  end

  def create
    @round = Round.find(params[:round_id])

    # 使用悲观锁来获取并锁定 @round 记录
    @round.with_lock do
      # 检查当前用户是否已经抽过号
      if @round.participants.where(user_id: @current_user.id).exists?
        render json: { error: '您已参与过本轮抽号' }, status: :unprocessable_entity
      else
        # 创建一个新的抽号记录
        @participant = Participant.new(participant_params)
        @participant.round = @round
        @participant.result = "0"

        content = @participant.name + @participant.company
        checking_res = message_check(content)
        if checking_res["errcode"] == 0
          @participant.user = @current_user
          if @participant.save
            render :show, status: :created
          else
            render_error
          end
        else
          render json: checking_res
        end
      end
    end

  end

  def update
    if @participant.update(participant_update_params)
      content = @participant.name + @participant.company
      checking_res = message_check(content)
      if checking_res["errcode"] == 0
        cal_result
        @participant.save
        render :show, status: :ok
      else
        render json: checking_res, status: :unprocessable_entity
      end
    else
      render_error
    end
  end
  

  private

  def set_participant
    @participant = Participant.find(params[:id])
    # @participant = Participant.find(1)
  end

  def participant_params
    params.require(:participant).permit(:name, :company)
  end

  def participant_update_params
    params.require(:round_participant).permit(:name, :company)
  end

  def render_error
    render json: { errors: @participant.errors.full_messages },
    status: :unprocessable_entity
  end

  def cal_result
    set_participant
    target_num = @participant.round.target.to_i
    
    # Convert serialized arrays to actual arrays
    @participant.round.arrayraw = @participant.round.arrayraw.map(&:to_i)
    @participant.round.arraynew = @participant.round.arraynew.map(&:to_i)
    
    if @participant.company.include?(@participant.round.keyword)
      if @participant.round.arrayraw.include?(target_num)
        @participant.result = target_num
        @participant.round.arrayraw.delete(target_num)
      else
        @participant.result = 0
      end
    else
      if @participant.round.arraynew.empty?
        @participant.result = 0
      else
        selected_num = @participant.round.arraynew.sample
        @participant.result = selected_num
        @participant.round.arraynew.delete(selected_num)
      end
    end
    
    # Convert arrays back to serialized format and save
    @participant.round.arrayraw = @participant.round.arrayraw.map(&:to_s)
    @participant.round.arraynew = @participant.round.arraynew.map(&:to_s)
    
    # Save the changes to the arrays in the database
    @participant.round.update(arrayraw: @participant.round.arrayraw, arraynew: @participant.round.arraynew)
    
    # Save the participant object
    @participant.save
  end
  
  
end
  