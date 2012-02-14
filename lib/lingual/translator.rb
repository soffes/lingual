require 'easy_translate'

module Lingual
  class Translator
    def initialize(reference_language)
      @reference_language = reference_language
    end
    
    def translate
      extractor = Extractor.new
      languages = extractor.extract!
      
      # Remove reference files from languages
      reference_files = languages.delete(@reference_language)
      
      # Loop through each language
      languages.each do |language, files|
        
        # Loop through all of the reference files
        reference_files.each do |file_name, reference_strings|
          # Get language strings
          language_strings = (files[file_name] or {})
          
          # Find missing keys to translate
          keys_to_translate = reference_strings.keys - language_strings.keys
          next if keys_to_translate.empty?
          
          # Translate missing keys
          translated = {}
          keys_to_translate.each do |key|
            translated[key] = EasyTranslate.translate(reference_strings[key], :from => @reference_language, :to => language)
          end
          
          # Write to file
          File.open("#{language}.lproj/#{file_name}.strings", 'a') do |f|
            translated.each do |key, value|
              f.write %Q{"#{key}" = "#{value}"; // Translated by Google Translate\n}
            end
          end
        end
      end
    end
  end
end
