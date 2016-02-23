class CargoEmpleadosController < ApplicationController
  before_action :set_cargo_empleado, only: [:show, :edit, :update, :destroy]

  # GET /cargo_empleados
  # GET /cargo_empleados.json
  def index
    @cargo_empleados = CargoEmpleado.all
  end

  # GET /cargo_empleados/1
  # GET /cargo_empleados/1.json
  def show
  end

  # GET /cargo_empleados/new
  def new
    @cargo_empleado = CargoEmpleado.new
  end

  # GET /cargo_empleados/1/edit
  def edit
  end

  # POST /cargo_empleados
  # POST /cargo_empleados.json
  def create
    @cargo_empleado = CargoEmpleado.new(cargo_empleado_params)

    respond_to do |format|
      if @cargo_empleado.save
        format.html { redirect_to @cargo_empleado, notice: 'Cargo empleado was successfully created.' }
        format.json { render :show, status: :created, location: @cargo_empleado }
      else
        format.html { render :new }
        format.json { render json: @cargo_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargo_empleados/1
  # PATCH/PUT /cargo_empleados/1.json
  def update
    respond_to do |format|
      if @cargo_empleado.update(cargo_empleado_params)
        format.html { redirect_to @cargo_empleado, notice: 'Cargo empleado was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargo_empleado }
      else
        format.html { render :edit }
        format.json { render json: @cargo_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargo_empleados/1
  # DELETE /cargo_empleados/1.json
  def destroy
    @cargo_empleado.destroy
    respond_to do |format|
      format.html { redirect_to cargo_empleados_url, notice: 'Cargo empleado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargo_empleado
      @cargo_empleado = CargoEmpleado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cargo_empleado_params
      params.fetch(:cargo_empleado, {})
    end
end
