# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


users = Empleado.create ([{email: 'calde@algo.com', emp_rut: '18293486-0', cargo_cod: 2, password: '12345678', password_confirmation: '12345678'},
                          {email: 'daniel@algo.com', emp_rut: '18519095-1', cargo_cod: 2, password: '12345678', password_confirmation: '12345678'},
                          {email: 'vero@algo.com', emp_rut: '5893349-k', cargo_cod: 2, password: '12345678', password_confirmation: '12345678'}])

