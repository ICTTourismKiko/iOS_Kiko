# Uncomment this line to define a global platform for your project
platform :ios, ’11.0’
target 'キーコ紀行' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
pod 'RealmSwift'
pod 'SKPhotoBrowser', :git => 'https://github.com/suzuki-0000/SKPhotoBrowser.git'
  # Pods for キーコ紀行
  target 'キーコ紀行Tests' do
    inherit! :search_paths
    # Pods for testing
  end
  target 'キーコ紀行UITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end
