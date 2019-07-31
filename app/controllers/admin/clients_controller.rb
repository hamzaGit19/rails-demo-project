# frozen_string_literal: true

class Admin::ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update destroy show]

  def new; end

  def show; end

  def index
    @clients = Client.page(params[:page])
  end

  def edit; end

  def update
    respond_to do |format|
      if @client.update(create_params)
        format.html { redirect_to admin_clients_path, notice: 'Client was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    redirect_to admin_clients_path, notice: 'Client deleted.'
  end

  def create
    @client = Client.new(create_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to dashboard_root_path, notice: 'Client was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def create_params
    params.require(:client).permit(:name, :email, :company, :phone, :referred_by, :country, :compnay_phone)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
