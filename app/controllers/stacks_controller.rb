class StacksController < ApplicationController

  respond_to :html, :json

  def index
    @stacks = StackDecorator.decorate(Stack.all)
    respond_with(@stacks)
  end

  def show
    @stack = StackDecorator.new(Stack.find(params[:id]))
    respond_with(@stack)
  end

  def new
    @stack = Stack.new
  end

  def edit
    @stack = Stack.find(params[:id])
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