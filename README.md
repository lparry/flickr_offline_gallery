# FlickrOfflineGallery

A tool to cache an offline copy of a flickr photoset, complete with all the html
embed snippets for all available sizes, allowing you to pick out photos for
blog posts/etc even without an internet connection.

## Installation

    $ gem install flickr_offline_gallery

## Usage

    $ FLICKR_API_KEY='<api_key>' FLICKR_SHARED_SECRET='<shared_secret>' flickr_offline_gallery <Flickr photoset id>

In a url like
`http://www.flickr.com/photos/83213379@N00/sets/72157636831703404/`, the
photoset id is the last part. ie `72157636831703404`

## Contributing

1. Fork it ( http://github.com/lparry/flickr_offline_gallery/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
