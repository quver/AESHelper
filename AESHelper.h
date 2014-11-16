//
//  AESHelper.h
//  Decryption
//
//  Created by Pawel Bednorz on 24.10.2014.
//  Copyright (c) 2014 Pawel Bednorz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESHelper : NSObject

+(NSString *)decryptBase64:(NSString *)encryptedBase64String withKey:(NSString *)key;

@end
