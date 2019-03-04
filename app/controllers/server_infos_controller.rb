# frozen_string_literal: true

class ServerInfosController < ApplicationController
  def destroy
    ServerInfo.destroy(params[:id])
    redirect_to(root_path, notice: 'Server Node deleted.')
  end
end
