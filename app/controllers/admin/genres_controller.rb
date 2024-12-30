class Admin::GenresController < ApplicationController
  layout 'admin'

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to admin_genres_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :edit
    end

  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "正常に登録しました"
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      flash[:alert] = "登録に失敗しました"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
