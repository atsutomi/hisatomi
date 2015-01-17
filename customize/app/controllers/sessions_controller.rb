# coding: utf-8

class SessionsController < ApplicationController
  def create
    member = Member.authenticate(params[:login_id], params[:password])
    if member
      session[:member_id] = member.id
      admin_check = member.admin
    else
      flash.alert = "名前とパスワードが一致しません"
    end

    if admin_check
      redirect_to params[:admin_root] || :admin_root
    else
      redirect_to params[:from] || :root
    end
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end
