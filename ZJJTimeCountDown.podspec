
Pod::Spec.new do |s|
s.name         = 'ZJJTimeCountDown'
s.version      = '1.0.1'
s.summary      = '一个已封装，简单易用的倒计时'
s.homepage     = 'https://github.com/04zhujunjie/ZJJTimeCountDown'
s.license      = 'MIT'
s.authors      = {'xiaozhu' => 'xswt04zjj@163.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/04zhujunjie/ZJJTimeCountDown.git', :tag => s.version}
s.source_files = 'ZJJTimeCountDown/*.{h,m}'
s.public_header_files = 'ZJJTimeCountDown/*.h'
s.requires_arc = true
end
