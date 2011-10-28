# Vacuum

Vacuum is a [Nokogiri][1]-backed Ruby wrapper to the [Amazon Product
Advertising API] [2].

[![travis] [3]] [4]

![vacuum] [5]
## Installation

Add to your Gemfile.

    gem 'vacuum'

## Usage

Set up a request.

    require "vacuum"

    req = Vacuum["us"]

    req.configure do |c|
      c.key    = AMAZON_KEY
      c.secret = AMAZON_SECRET
      c.tag    = AMAZON_ASSOCIATE_TAG
    end

Search for something.

    req << { :operation    => 'ItemSearch',
             :search_index => 'All',
             :keywords     => 'George Orwell' }
    res = request.get

Or use a shorthand.

    res = req.search('George Orwell')

Customise your request.

    res = req.search('Books', :response_group => 'ItemAttributes',
                              :power          => 'George Orwell'

For a reference of available methods and syntax, [read here] [6].

Consume the entire response.

    res.to_hash

Quickly drop down to a particular node.

    res.each('Item') do |item|
      puts item['ASIN']
    end

[Please see the project page] [7] for further detail.

[1]: http://nokogiri.org/
[2]: https://affiliate-program.amazon.co.uk/gp/advertising/api/detail/main.html
[3]: https://secure.travis-ci.org/hakanensari/vacuum.png
[4]: http://travis-ci.org/hakanensari/vacuum
[5]: https://github.com/hakanensari/vacuum/blob/master/vacuum.png?raw=true
[6]: https://github.com/hakanensari/vacuum/blob/master/lib/vacuum/operations.rb
[7]: http://code.papercavalier.com/amazon_product/
