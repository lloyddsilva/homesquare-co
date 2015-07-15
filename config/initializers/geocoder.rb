# config/initializers/geocoder.rb
Geocoder.configure(

  # geocoding service (see below for supported options):
  :lookup => :google,
  # :lookup => :bing,


  # to use an API key:
  # :api_key => "AsToXCcTNEIcAW9U6dnIyztnkPZW_xRqnnxQY7fTRnPrPWtZNwOWTyn0vMbPRkMk", # Expiration Date: 04/16/2014

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 10,

  # set default units to kilometers:
  :units => :km

)