module Searchable
  extend ActiveSupport::Concern

  # Setup the index mappings
  def self.setup_index_mappings
    models = [Content::Translation, Content::Transliteration, Quran::Ayah]
    settings = YAML.load( File.read( File.expand_path( "#{Rails.root}/config/elasticsearch/settings.yml", __FILE__ ) ) )
    mappings = YAML.load( File.read( File.expand_path( "#{Rails.root}/config/elasticsearch/mappings.yml", __FILE__ ) ) )

    models.first.__elasticsearch__.client.indices.create \
      index: "quran",
      body: { settings: settings, mappings: mappings }
  end


  # When this module is included, this callback function is called
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # Initial the paging gem, Kaminari
    Kaminari::Hooks.init
    Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

    class << self
      alias_method :importing, :import
      alias_method :searching, :search
    end

    self.index_name 'quran'
  end
end