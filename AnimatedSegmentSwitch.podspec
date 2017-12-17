Pod::Spec.new do |s|
  s.name             = "AnimatedSegmentSwitch"
  s.version          = "0.2.0"

  s.summary          = "AnimatedSegmentSwitch is a configurable multi-segment switch control written in Swift."
  s.description = <<-DESC
    Features
      * Up-to-date: Swift 2 (Xcode 7)
      * Support for Interface Designer
      * Supports multi-segments
      * Easy to use, lightweight, customizable and configurable
      * Works as UISegmentedControl and UISwitch drop-in replacement
  DESC
  s.homepage         = "https://github.com/toashd/AnimatedSegmentSwitch"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Tobias Schmid" => "toashd@gmail.com" }
  s.source           = { :git => "https://github.com/toashd/AnimatedSegmentSwitch.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/toashd'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'AnimatedSegmentSwitch/**/*.swift'
end
