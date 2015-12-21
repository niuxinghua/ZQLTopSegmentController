Pod::Spec.new do |s|
  s.name         = "ZQLTopSegmentController"
  s.version      = "0.0.1"
  s.summary      = "A ViewController Container"
  s.description  = <<-DESC
                    A ViewController Container
                   DESC
  s.homepage     = "https://github.com/zangqilong198812/ZQLTopSegmentController"
  s.screenshots  = "https://d262ilb51hltx0.cloudfront.net/max/800/1*pev9ZXJAZ2MYoF8-R_nbRA.gif"
  s.license      = 'MIT'
  s.author       = { "Zangqilong" => "zangqilong@gmail.com" }
  s.source       = { :git => "https://github.com/zangqilong198812/ZQLTopSegmentController.git", :tag => 0.0.1 }
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
end
