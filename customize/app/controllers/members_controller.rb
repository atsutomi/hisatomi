# coding: utf-8

class MembersController < ApplicationController
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
