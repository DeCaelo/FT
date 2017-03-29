require 'csv'

class ImportJob < ActiveJob::Base
  queue_as :default

  def perform(file)
    CSV.foreach(file, headers: true, header_converters: :symbol, col_sep: ';', encoding: "ISO8859-1") do |row|
      if (intercom = Intercommunality.find_by(siren: row[:siren_epci]))
      else
        row[:form_epci] = 'MET' if row[:form_epci] == 'METRO'
        intercom = Intercommunality.create(
          department: row[:dep_epci],
          siren: row[:siren_epci],
          name: row[:nom_complet],
          form: row[:form_epci].downcase,
          fisc: row[:fisc_epci]
        )
      end

      next if Commune.exists?(code_insee: row[:insee])
      Commune.create(
        intercommunality_id: intercom.id,
        department: row[:dep_com],
        code_insee: row[:insee],
        siren: row[:siren_com],
        name: row[:nom_com],
        population: row[:pop_total]
      )
    end
  end
end
