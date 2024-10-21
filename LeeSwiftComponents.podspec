Pod::Spec.new do |spec|
  spec.name         = "LeeSwiftComponents"
  spec.version      = "0.0.11"
  spec.summary      = "Swift Components."
  spec.description  = "Swift Basic Components."
  spec.homepage     = "https://github.com/Lee827/LeeSwiftComponents"
  spec.license      = "MIT"
  spec.platform     = :ios, "13.0"
  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"
  spec.author       = { "Elmo Lee" => "elmolee1992827@gmail.com" }
  spec.source       = { :git => "https://github.com/Lee827/LeeSwiftComponents.git", :tag => spec.version }
  spec.source_files  = "LeeSwiftComponents/**/*.{h,m,swift}"
end