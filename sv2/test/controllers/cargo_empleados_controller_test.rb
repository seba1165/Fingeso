require 'test_helper'

class CargoEmpleadosControllerTest < ActionController::TestCase
  setup do
    @cargo_empleado = cargo_empleados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cargo_empleados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cargo_empleado" do
    assert_difference('CargoEmpleado.count') do
      post :create, cargo_empleado: {  }
    end

    assert_redirected_to cargo_empleado_path(assigns(:cargo_empleado))
  end

  test "should show cargo_empleado" do
    get :show, id: @cargo_empleado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cargo_empleado
    assert_response :success
  end

  test "should update cargo_empleado" do
    patch :update, id: @cargo_empleado, cargo_empleado: {  }
    assert_redirected_to cargo_empleado_path(assigns(:cargo_empleado))
  end

  test "should destroy cargo_empleado" do
    assert_difference('CargoEmpleado.count', -1) do
      delete :destroy, id: @cargo_empleado
    end

    assert_redirected_to cargo_empleados_path
  end
end
