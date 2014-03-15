# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

operation = Operation.create({:descricao => 'RECOLHIMENTO'})
operation = Operation.create({:descricao => 'TROCA'})
operation = Operation.create({:descricao => 'ENTREGA'})
operation = Operation.create({:descricao => 'ABASTECIMENTO'})
operation = Operation.create({:descricao => 'REMANEJAMENTO'})

user = User.create({:email => 'thiagoramos.al@gmail.com', :password => 'thiago220582'})

(1..200).each do |i|
	material = Material.new
	material.id = i
	material.codigo = 'C' + i.to_s.rjust(3, '0')
	material.descricao = 'Contâiner ' + i.to_s
	material.peso = 24.0
	material.largura = 24.0
	material.altura = 24.0
	material.comprimento = 24.0
	material.cor = '#000000'
	material.in_deposito = true
	material.save

end