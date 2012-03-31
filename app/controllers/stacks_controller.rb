class StacksController < ApplicationController

  def index
    
  end

  def show
    @stack = Stack.find(params[:id])
  end
end