Pod::Spec.new do |s|

  s.name         = "XCSegumentView"
  s.version      = "1.0.0"
  s.summary      = "XCSegumentView"

  s.description  = "XCSegumentView自定义分段Segument"

  s.homepage     = "https://github.com/fanxiaocong/XCSegumentView"

  s.license      = "MIT"


  s.author       = { "樊小聪" => "1016697223@qq.com" }


  s.source       = { :git => "https://github.com/fanxiaocong/XCSegumentView.git", :tag => s.version }


  s.source_files = "XCSegumentView"
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.frameworks   =  'UIKit'

end

