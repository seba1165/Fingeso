class CotOdcArtsController < ApplicationController
  def index
    @cotodcArts = CotOdcArt.all()
  end

  def new
    @doc = DocPrevio.new
    @doc.cliente = Cliente.new
    @cotodcArt = CotOdcArt.new
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
    @cotodcArt = CotOdcArt.find(params[:id]);
  end
end
