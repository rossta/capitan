class StacksController < ApplicationController

  respond_to :html, :js

  def index
    @stacks = StackDecorator.decorate(Stack.all)    
  end

  def show
    @stack = StackDecorator.new(Stack.find(params[:id]))
  end

  def new
    @stack = Stack.new
  end

  def create
    @stack = Stack.new(params[:stack])
    @stack.save
    set_flash_message(@stack)
    respond_with(@stack)
  end

  def update
    @stack = Stack.find(params[:id])
    @stack.update_attributes(params[:stack])

    @stack.save
    set_flash_message(@stack)
    respond_with(@stack)
  end

  private

  def set_flash_message(stack)
    if stack.errors.any?
      flash[:error] = @stack.errors.full_messages
    else
      flash[:success] = "Your stack has been updated!"
    end
  end
end