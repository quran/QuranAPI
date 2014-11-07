class Quran::TextRoot < ActiveRecord::Base
    extend Quran
    extend Batchelor

    self.table_name = 'text_root'
    self.primary_key = 'id'

    belongs_to :ayah, class_name: 'Quran::Ayah'

    def self.import(options = {})
        transform = lambda do |a|
            {index: {_id: "#{a.id}", _parent: a.ayah_key, data: a.__elasticsearch__.as_indexed_json}}
        end
        options = {transform: transform}.merge(options)
        self.importing options
    end
end