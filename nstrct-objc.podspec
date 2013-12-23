Pod::Spec.new do |s|
  s.name = "nstrct-objc"
  s.version = "0.1.0"
  s.summary = "a multi-purpose binary protocol for instruction interchange"
  s.description = <<-DESC
                   Interchange formats like json or xml are great to keep data visible, but due to their parse and pack complexity they aren't used in embedded applications. There are alternatives like msgpack or Google's protocol buffer, which allow a more binary representation of data, but these protcols are still heavy and developers tend to rather implement their own 'simple' binary protocols instead of porting or using the big ones. 
                  DESC
  s.homepage = "https://github.com/nstrct/nstrct-objc"
  s.license = 'MIT'
  s.author = { "Joël Gähwiler" => "joel.gaehwiler@bluewin.ch" }
  s.source = { git: "https://github.com/nstrct/nstrct-objc.git", tag: s.version.to_s }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation'
end
