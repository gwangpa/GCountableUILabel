#
# Be sure to run `pod lib lint GCountableUILabel.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GCountableUILabel"
  s.version          = "0.1.0"
  s.summary          = "CountDown animation effect UILabel"
  s.description      = <<-DESC
                       Vine' loop animation style UILabel

                       Just change text value in some loop
                       DESC
  s.homepage         = "https://github.com/gwangpa/GCountableUILabel"
  s.license          = 'MIT'
  s.author           = { "Daniel KIM" => "gwangpa@gmail.com" }
  s.source           = { :git => "https://github.com/gwangpa/GCountableUILabel.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GCountableUILabel' => ['Pod/Assets/*.png']
  }
end
