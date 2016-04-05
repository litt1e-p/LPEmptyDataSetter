Pod::Spec.new do |s|
  s.name             = "LPEmptyDataSetter"
  s.version          = "0.0.1"
  s.summary          = "create placeholder view for empty data UIViewController/UITableViewController/UICollectionViewController, etc."
  s.description      = <<-DESC
                       create placeholder view for empty data UIViewController/UITableViewController/UICollectionViewController, etc. which needs one line code only!
                       DESC
  s.homepage         = "https://github.com/litt1e-p/LPEmptyDataSetter"
  s.license          = { :type => 'MIT' }
  s.author           = { "litt1e-p" => "litt1e.p4ul@gmail.com" }
  s.source           = { :git => "https://github.com/litt1e-p/LPEmptyDataSetter.git", :tag => '0.0.1' }
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'LPEmptyDataSetter/*'
  s.frameworks = 'Foundation', 'UIKit'
end
