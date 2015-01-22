# coding: utf-8

class Admin::MembersController < Admin::Base
  # 会員一覧
  def index
    @members = Member.order("id")
  end

  # 会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end

end
