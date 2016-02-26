require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
  test "should get inicio" do
    get :inicio
    assert_response :success
  end
  test "should get cotizacion" do
    get :cotizacion
    assert_response :success
  end

  test "should get nuevCot" do
    get :nuevCot
    assert_response :success
  end
  
  test "should get nCotAgregArt" do
    get :nCotAgregArt
    assert_response :success
  end

  test "should get anularCot" do
    get :anularCot
    assert_response :success
  end

  test "should get aprobCot" do
    get :aprobCot
    assert_response :success
  end

  test "should get abrirCot" do
    get :abrirCot
    assert_response :success
  end

  test "should get ordComp" do
    get :ordComp
    assert_response :success
  end

  test "should get nuevaOC" do
    get :nuevaOC
    assert_response :success
  end

  test "should get anularOC" do
    get :anularOC
    assert_response :success
  end

  test "should get aprobOC" do
    get :aprobOC
    assert_response :success
  end

  test "should get abrirOC" do
    get :abrirOC
    assert_response :success
  end

  test "should get OT" do
    get :OT
    assert_response :success
  end

  test "should get anularOT" do
    get :anularOT
    assert_response :success
  end

  test "should get editarOT" do
    get :editarOT
    assert_response :success
  end

  test "should get finOT" do
    get :finOT
    assert_response :success
  end

  test "should get notVent" do
    get :notVent
    assert_response :success
  end

  test "should get genNV" do
    get :genNV
    assert_response :success
  end

  test "should get pagoNV" do
    get :pagoNV
    assert_response :success
  end

  test "should get cotAgHerr" do
    get :cotAgHerr
    assert_response :success
  end

  test "should get cotAgRepto" do
    get :cotAgRepto
    assert_response :success
  end

  test "should get cotAgAcc" do
    get :cotAgAcc
    assert_response :success
  end

  test "should get cotAgRepar" do
    get :cotAgRepar
    assert_response :success
  end

  test "should get cotAgIns" do
    get :cotAgIns
    assert_response :success
  end

  test "should get parametro" do
    get :parametro
    assert_response :success
  end

  test "should get registro" do
    get :registro
    assert_response :success
  end

  test "should get cotPrev" do
    get :cotPrev
    assert_response :success
  end

  test "should get cotFinal" do
    get :cotFinal
    assert_response :success
  end

end