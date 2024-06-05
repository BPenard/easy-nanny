class ChildrenController < ApplicationController

  def index
    @children = policy_scope(Child)
  end

  def new
    @child = Child.new
    authorize @child
  end

  def create
    @child = Child.new(child_params)
    @child.user = current_user
    if @child.save
      redirect_to children_path
    else
      render :new, status: :unprocessable_entity
    end

    authorize @child
  end

  def edit
    @child = Child.find(params[:id])
    authorize @child
  end

  def update
    @child = Child.find(params[:id])
    @child.update(child_params)
    redirect_to children_path
    authorize @child
  end

  private
  def child_params
    params.require(:child).permit(:last_name, :first_name, :birthdate)
  end
end
