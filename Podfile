# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'ChatMobile' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftyRSA'
pod 'CryptoSwift'
pod 'SwiftyJSON'
pod 'Alamofire'
pod 'IQKeyboardManagerSwift'
rfpod 'SDWebImage'
pod 'ObjectMapper'


post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
  end
 end
end
  # Pods for ChatMobile

end
