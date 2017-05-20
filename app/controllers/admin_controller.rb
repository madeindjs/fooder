class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin
end
