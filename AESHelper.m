//
//  AESHelper.m
//  Decryption
//
//  Created by Pawel Bednorz on 24.10.2014.
//  Copyright (c) 2014 Quver.xyz. All rights reserved.
//

#import "AESHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation AESHelper

/**
 *  Decryption for string encrypted with AES 128 ECB and key length of 128 bits.
 *
 *  @param encryptedBase64String Encrypted string encoded in Base64
 *  @param key                   Key length of 16 characters in UTF-8
 *
 *  @return Plain text
 */
+ (NSString *)decryptBase64:(NSString *)encryptedBase64String withKey:(NSString *)key {

    char keyBytes[key.length+1];
    bzero(keyBytes, sizeof(keyBytes));

    if (![key getCString:keyBytes maxLength:sizeof(keyBytes) encoding:NSUTF8StringEncoding]) {
        return nil;
    }

    NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:encryptedBase64String options:0];

    size_t numBytesDecrypted = 0;
    size_t decryptedLength = encryptedData.length + kCCBlockSizeAES128;
    char *decryptedBytes = malloc(decryptedLength);

    CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES128 ,
                                     kCCOptionECBMode | kCCOptionPKCS7Padding,
                                     keyBytes,
                                     key.length,
                                     nil,
                                     encryptedData.bytes,
                                     encryptedData.length,
                                     decryptedBytes,
                                     decryptedLength,
                                     &numBytesDecrypted);

    if(result != kCCSuccess) {
        return nil;
    }

    NSData *decryptedData = [NSData dataWithBytesNoCopy:decryptedBytes length:numBytesDecrypted];
    NSString *decryptedString = [NSString stringWithUTF8String:decryptedData.bytes];

    return decryptedString;
}

@end
