# encoding: UTF-8

require 'easy_translate'

module Lingual
  class Translator
    def self.google_api_key=(api_key)
      EasyTranslate.api_key = api_key
    end
    
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
          language_strings = files[file_name]
          next unless language_strings # Skip missing files for now 
          
          # Find missing keys to translate
          keys_to_translate = reference_strings.keys - language_strings.keys
          next if keys_to_translate.empty?
          
          # Translate missing keys
          translated = {}
          keys_to_translate.each do |key|            
            # Convert Chinese
            to = language
            to = 'zh-CN' if language.downcase == 'zh_hans'
            to = 'zh-TW' if language.downcase == 'zh_hant'
            
            puts "Translating #{key} in #{language}#{to != language ? " (#{to})" : ''}"
            
            translated[key] = EasyTranslate.translate(reference_strings[key], :from => @reference_language, :to => to)
          end
          
          # Write to file
          File.open("#{language}.lproj/#{file_name}.strings", 'a') do |f|
            f.write "\n\n"
            
            translated.each do |key, value|
              f.write %Q{"#{key}" = "#{value}"; // Translated by Google Translate\n}
            end
          end
        end
      end
      
      true
    end
  end
end
