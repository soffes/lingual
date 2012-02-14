module Lingual
  class Translator
    def initialize(reference_language)
      @reference_language = reference_language
    end
    
    def translate
      extractor = Extractor.new
      extraction = extractor.extract!
      
      reference_files = extraction.delete(@reference_language)
      
      # TODO: Make all of the things
      # reference_files.each do |file_name, strings|
      #   reference_strings = reference_files[file_name]
      #   (reference_strings.keys - strings.keys).each do |key|
      #     translated = Google::Translate.translate(:from => @reference_language, :to => language, :text => reference_strings[key])
      #     # TODO: Write
      #   end
      # end
    end
  end
end
