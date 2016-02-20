require 'test_helper'

class VendedorControllerTest < ActionController::TestCase
#INICIO
	test "should get inicio" do
	    get :inicio
	    assert_response :success
	  end

#VENTAS
	#cotizaciones
		test "should get cotizacion" do
	    get :cotizacion
	    assert_response :success
	  end
	#órdenes de compra
	  test "should get ordComp" do
	    get :ordComp
	    assert_response :success
	  end
	#notas de ventas
	  test "should get notVen" do
	    get :notVen
	    assert_response :success
	  end

	#COTIZACION
		#Nueva cotizacion
			test "should get nuevaCot" do
		    get :nuevaCot
		    assert_response :success
		  end
		#anular cotizacion
		  test "should get anular" do
		    get :anular
		    assert_response :success
		  end
		#Aprobar cotizacion
		  test "should get aprobar" do
		    get :aprobar
		    assert_response :success
		  end
		#Abrir cotizacion
		  test "should get abir" do
		    get :abrir
		    assert_response :success
		  end

	#ORDEN DE COMPRA
		#Nueva orden de compra
		  test "should get nuevaOC" do
		    get :nuevaOC
		    assert_response :success
		  end
		#Anular orden de compra
		  test "should get anularOC" do
		    get :anularOC
		    assert_response :success
		  end
		#Aprobar orden de compra
		  test "should get aprobarOC" do
		    get :aprobarOC
		    assert_response :success
		  end
		#Abrir orden de compra
		  test "should get abrirOC" do
		    get :abrirOC
		    assert_response :success
		  end
#CLIENTES Y VEHICULOS
	#CLIENTES
		test "should get clientes" do
		    get :clientes
		    assert_response :success
		  end
	#VEHÍCULOS
		test "should get vehiculos" do
		    get :vehiculos
		    assert_response :success
		  end
end
