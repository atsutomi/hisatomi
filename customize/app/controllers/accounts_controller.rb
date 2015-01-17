# coding: utf-8

class AccountsController < ApplicationController
  #個人情報編集フォーム
  def edit
    @member = @current_member
  end

  def update
    @member = @current_member
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to :edit_account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end
end
