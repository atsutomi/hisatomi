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

  def new
    @member = Member.new
  end

  # 会員の新規登録
  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to :root
    else
      render "new"
    end
  end
end
