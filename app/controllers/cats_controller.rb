class CatsController < ApplicationController

  def index
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      # @errors = @cat.errors.full_messages
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(cat_params)
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :color, :description, :birth_date, :sex)
  end
end
