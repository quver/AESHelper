//
//  AESHelper.h
//  Decryption
//
//  Created by Pawel Bednorz on 24.10.2014.
//  Copyright (c) 2014 Quver.xyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESHelper : NSObject

/**
 *  Decryption for string encrypted with AES 128 ECB and key length of 128 bits.
 *
 *  @param encryptedBase64String Encrypted string encoded in Base64
 *  @param key                   Key length of 16 characters in UTF-8
 *
 *  @return Decrypted text
 */
+ (NSString *)decryptBase64:(NSString *)encryptedBase64String withKey:(NSString *)key;

@end
