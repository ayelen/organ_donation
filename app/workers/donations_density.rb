require 'open-uri'
require 'kafka'
require 'csv'

class DonationsDensity < Kafka::Consumer

  def call
    # it doesn't have much sense because the file is not working as expected, so I had to touch it manually.
    path = 'http://datos.salud.gob.ar/dataset/554aad34-5213-47ba-b9d5-5ce63c494de9/resource/8248716d-a9a0-4b1e-9577-2fe1c6bbaea6/download/expresiones-voluntad-provincia-incucai-20190902.json'
    download =  URI.open(path)
    file_name = "#{DateTime.now.to_s(:number)}_data.json"
    IO.copy_stream(download, Rails.root.join('downloads', file_name))

    density_json = JSON.parse File.read(Rails.root.join('downloads', 'data.json'))

    density_json.with_indifferent_access.each do |prov|
      province = Province.where(name: prov[:provincia_descripcion]).first_or_initialize
      province.update_attributes(positive_quantity: prov[:manifestacion_afirmativa_cantidad], negative_quantity: prov[manifestacion_negativa_cantidad])
    end
  end

  def initialize
    # Should it be here?
    kafka = Kafka.new(["localhost:9092"])

    consumer = kafka.consumer(group_id: "donations-density-group")

    consumer.subscribe("donations-density")

    trap("TERM") { consumer.stop }

    consumer.each_message do |message|
      puts message.topic, message.partition
      puts message.offset, message.key, message.value
    end
  end
end
