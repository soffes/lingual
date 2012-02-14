# Lingual

Work in progress gem for temporary localization for Objective-C projects. Say you added some strings at the last minute and don't have time to get them translated. Simply run `lingual` to automatically detect missing strings and Google Translate them.

## Installation

    $ gem install lingual

## Usage

A CLI is on my todo list. For now you can use it with the following commands:

    $ git clone https://github.com/samsoffes/lingual.git
    $ cd lingual
    $ bundle
    $ bundle console
    > Dir.chdir('your_project/Resources')
    > Lingual::Translator.google_api_key = 'your_api_key'
    > translator = Lingual::Translator.new('en')
    > translator.translate

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
