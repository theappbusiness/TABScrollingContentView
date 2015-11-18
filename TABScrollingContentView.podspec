Pod::Spec.new do |s|
  s.name         = 'TABScrollingContentView'
  s.version      = '0.0.1'
  s.platform	 = :ios, '8.0'
  s.license      = 'LICENSE'
  s.author       = { "The App Business" => "https://www.theappbusiness.com" }
  s.homepage     = 'https://www.theappbusiness.com'
  s.requires_arc = true
  s.summary      = 'Scrolling content view that gets its size from the auto layout constraints of its subviews'
  s.source       = { :git => 'ssh://git@bitbucket.org:theappbusiness/scrollingcontentview.git', :tag => s.version.to_s }
  s.source_files = 'TABScrollingContentView/**/*.swift'
end
