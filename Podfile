# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


plugin 'cocoapods-keys', {
  :project => "Weather",
  :target => "Weather",
  :keys => [
    "ApiKey"
  ]
}


target 'Weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Weather

  pod 'SwiftLint'
  pod 'SDWebImage', '~> 5.0'
  pod 'Moya', '~> 14.0'

  target 'WeatherTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WeatherUITests' do
    # Pods for testing
  end

end
