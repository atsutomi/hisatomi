# coding: utf-8

class Admin::Base < ApplicationController
  before_filter :admin_login_required, :except=> [:new, :create]

  private
  def admin_login_required
    raise Forbidden unless @current_member.try(:admin?)
  end
end
