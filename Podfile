# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'WebTruong' do
pod 'SlideMenuControllerSwift'
pod 'Alamofire'
pod 'DropDown'
pod 'SwiftyJSON'
pod 'DLRadioButton', '~> 1.4'
pod 'Kingfisher', '~> 3.0'
pod 'RATreeView'
pod 'CardIO'
pod 'Google/CloudMessaging'
pod 'Kanna', '~> 2.1.0'
pod 'PayPal-iOS-SDK'
pod 'MIBadgeButton-Swift', '~> 0.4'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end


