//
//  test.m
//  exivtest
//
//  Created by Kanstantsin Bucha on 1/17/18.
//  Copyright © 2018 Truebucha. All rights reserved.
//

#import "TestExiv.h"
#import "exiv2.hpp"

using namespace Exiv2;


size_t formatInit(Exiv2::ExifData& exifData) {
    size_t result = 0;
    for (Exiv2::ExifData::const_iterator i = exifData.begin(); i != exifData.end() ; ++i) {
        result ++ ;
    }
    return result ;
}

std::string escapeJSON(Exiv2::ExifData::const_iterator it,bool bValue=true) {
    std::string   result ;
    
    std::ostringstream os;
    if ( bValue ) os << it->value() ; else os << it->key() ;
    
    std::string s = os.str();
    for ( size_t i = 0 ;i < s.length() ; i ++ ) {
        if ( s[i] == '"' ) result += "\\\"";
        result += s[i];
    }
    
    std::string q = "\"";
    return q + result + q ;
}

std::string formatJSON(Exiv2::ExifData& exifData) {
    size_t count  = 0;
    size_t length = formatInit(exifData);
    std::ostringstream result;
    
    result << "{" << std::endl ;
    for (Exiv2::ExifData::const_iterator i = exifData.begin(); count++ < length ; ++i) {
        result << "  " << escapeJSON(i,false)  << ":" << escapeJSON(i,true) << ( count != length ? "," : "" ) << std::endl ;
    }
    result << "}";
    return result.str();
}

void exifPrint(const ExifData& exifData)
{
    ExifData::const_iterator i = exifData.begin();
    for (; i != exifData.end(); ++i) {
        std::cout << std::setw(44) << std::setfill(' ') << std::left
        << i->key() << " "
        << "0x" << std::setw(4) << std::setfill('0') << std::right
        << std::hex << i->tag() << " "
        << std::setw(9) << std::setfill(' ') << std::left
        << i->typeName() << " "
        << std::dec << std::setw(3)
        << std::setfill(' ') << std::right
        << i->count() << "  "
        << std::dec << i->value()
        << "\n";
    }
}

@implementation TestExiv

- (void) readFrom: (NSString *) filePath {
    try {
        const char* file = [filePath cStringUsingEncoding: [NSString defaultCStringEncoding]];
        Exiv2::Image::AutoPtr image = Exiv2::ImageFactory::open(file);
        assert(image.get() != 0);
        
        image->readMetadata();
        Exiv2::ExifData &exifData = image->exifData();
//        std::cout << formatJSON(exifData) << std::endl;
        exifPrint(exifData);
        
    } catch (Exiv2::AnyError& e) {
        std::cerr << "*** error exiv2 exception '" << e << "' ***" << std::endl;
    } catch (...) {
        std::cerr << "*** error exception ***" << std::endl;
    }
}

- (NSString *) readJSONStringFrom: (NSString *) filePath {
    NSString * result = nil;
    try {
        const char* file = [filePath cStringUsingEncoding: [NSString defaultCStringEncoding]];
        Exiv2::Image::AutoPtr image = Exiv2::ImageFactory::open(file);
        assert(image.get() != 0);
        
        image->readMetadata();
        Exiv2::ExifData &exifData = image->exifData();
        std::string json = formatJSON(exifData);
        const char* jsonC = json.c_str();
        result = [NSString stringWithCString: jsonC
                                    encoding: [NSString defaultCStringEncoding]];
        
    } catch (Exiv2::AnyError& e) {
        std::cerr << "*** error exiv2 exception '" << e << "' ***" << std::endl;
        return nil;
    } catch (...) {
        std::cerr << "*** error exception ***" << std::endl;
        return nil;
    }
    
    return result;
}

@end
