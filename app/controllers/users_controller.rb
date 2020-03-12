class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit1_basic_info, :update_basic1_info, :edit2_basic_info, :update_basic2_info, :edit3_basic_info, :update_basic3_info, :edit4_basic_info, :update_basic4_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit1_basic_info, :update_basic1_info, :edit2_basic_info, :update_basic2_info, :edit3_basic_info, :update_basic3_info, :edit4_basic_info, :update_basic4_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :update]
  before_action :admin_or_correct_user, only: [:show, :edit1_basic_info]
  before_action :set_one_month, only: [:show, :edit1_basic_info, :update_basic1_info]

  def index
    @users = User.all
      respond_to do |format|
        format.html do
        end
        format.csv do
          send_data render_to_string, filename: "(ファイル名).csv", type: :csv
        end
      end
    if params[:search]
      @users = User.where('LOWER(name) LIKE ?', "%#{params[:search][:name].downcase}%").paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end
  
    def import
     User.import(params[:file])
     redirect_to root_url
    end

  def show
    @attendances_list = Attendance.where(name: current_user.name).where.not(user_id: params[:id])
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end
  

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

   def will_paginate
   end
   
   def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集期限がありません。" 
        redirect_to(root_url)
      end
   end
   

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
    
end