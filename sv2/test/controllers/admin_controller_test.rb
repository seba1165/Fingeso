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
  
  test "should get usr" do
    get :usr
    assert_response :success
  end

  test "should get agregUsr" do
    get :agregUsr
    assert_response :success
  end

  test "should get editUsr" do
    get :editUsr
    assert_response :success
  end

  test "should get elimUsr" do
    get :elimUsr
    assert_response :success
  end

end
