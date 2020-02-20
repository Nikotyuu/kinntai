class ApprovalsController < ApplicationController
  protect_from_forgery
  before_action :set_user, only: :update
  
  def index
  end
  
  def create
    @user = User.find(params[:user_id])
    @approval = @user.approvals.create()
    @superior_user = User.where(superior: true)
      if @approval.update_attributes(approvals_params)
        flash[:success] = "申請しました！"
      else
        
      end
  end
  
  private
    def approvals_params
      params.require(:approval).permit(:superior_id)
    end
end