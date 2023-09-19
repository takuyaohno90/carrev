class User::UsersController < ApplicationController
  def show
    @reviews = current_user.reviews
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の編集に成功しました。"
      redirect_to user_mypage_path
    else
      flash[:alert] = "ユーザー情報の編集に失敗しました。"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :last_name_kana, :first_name_kana, :email)
  end

end
