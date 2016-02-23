json.array!(@cargo_empleados) do |cargo_empleado|
  json.extract! cargo_empleado, :id
  json.url cargo_empleado_url(cargo_empleado, format: :json)
end
