Pod::Spec.new do |s|
s.name	=	'GoogleDistanceMatrixWrapper'
s.version	=	'0.0.1'
s.platform     =  :ios, '6.0'
s.summary = 'Google Distance Matrix iOS wrapper for more info check: https://developers.google.com/maps/documentation/distancematrix/'
s.author = {
	'Antonio Pinho' => 'antoniopinho88@gmail.com'
}
s.source = {
	:git => 'https://github.com/trant/googledistancematrixwrapper.git',
	:tag => '0.0.1'
}
s.homepage =  'https://github.com/trant/googledistancematrixwrapper'
s.source_files =  'Classes/*.{h,m}'
s.dependency	'AFNetworking', '2.2'
s.requires_arc = true
s.license      =  'Apache License, Version 2.0'
s.frameworks = 'Foundation', 'UIKit'
s.prefix_header_contents = '#import "NSError+Additions.h"','#import <AFNetworking.h>'

end
