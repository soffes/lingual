module Lingual
  class Extractor
    LINE_COMMENT_PATTERN = /\/\/([^\n]+)\n/
    BLOCK_COMMENT_PATTERN = /\/\*(.*)\*\//m
    KEY_VALUE_PATTERN = /^(?:\"(.+)\")(?:[\s+])?=(?:[\s+])?(?:\"(.+)\");$/
    
    def extract!
      # language / file / key / value
      @localizations = {}
      
      languages = Dir['*.lproj'].collect { |lang| lang.gsub('.lproj', '') }
      languages.each do |language|
        @localizations[language] = {}
        
        files = Dir["#{language}.lproj/*.strings"].collect do |file|
          file.gsub("#{language}.lproj/", '').gsub('.strings', '')
        end
        
        files.each do |file|
          @localizations[language][file] = extract_file("#{language}.lproj/#{file}.strings")
        end
      end
      
      @localizations
    end
    
    private
    
    def extract_file(path)
      file = File.open(path, 'r').read
      
      # Remove comments
      file.gsub(LINE_COMMENT_PATTERN, '').gsub(BLOCK_COMMENT_PATTERN, '')
      
      hash = {}
      
      # Extract keys and values
      file.split("\n").each do |line|
        matches, key, value = line.match(KEY_VALUE_PATTERN).to_a
        next unless key and value  
        hash[key] = value
      end
      
      hash
    end
  end
end
