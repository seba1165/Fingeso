class CotOdcArtsController < ApplicationController
  def index
    @cots = CotOdcArt.all()
  end

  def new
    @arts = Articulo.all
  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy
  end

  def elimCotODCArt

  end
end
