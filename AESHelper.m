//
//  AESHelper.m
//  Decryption
//
//  Created by Pawel Bednorz on 24.10.2014.
//  Copyright (c) 2014 Pawel Bednorz. All rights reserved.
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
+(NSString *)decryptBase64:(NSString *)encryptedBase64String withKey:(NSString *)key
{
    int keyLength = (int)[key length];
    if(keyLength != kCCKeySizeAES128)
    {
        #ifdef DEBUG
            NSLog(@"AESHelper - Error - Key must be 128 bits in length");
        #endif
        return nil;
    }
    
    char keyBytes[keyLength+1];
    bzero(keyBytes, sizeof(keyBytes));
    [key getCString:keyBytes maxLength:sizeof(keyBytes) encoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:encryptedBase64String options:0];
    
    size_t numBytesDecrypted = 0;
    size_t decryptedLength = [encryptedData length] + kCCBlockSizeAES128;
    char* decryptedBytes = malloc(decryptedLength);
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES128 ,
                                     kCCOptionECBMode | kCCOptionPKCS7Padding,
                                     keyBytes,
                                     keyLength,
                                     nil,
                                     [encryptedData bytes],
                                     [encryptedData length],
                                     decryptedBytes,
                                     decryptedLength,
                                     &numBytesDecrypted);
    
    if(result == kCCSuccess){
        NSData *decryptedData = [NSData dataWithBytesNoCopy:decryptedBytes length:numBytesDecrypted];
        NSString *decryptedString = [NSString stringWithUTF8String:[decryptedData bytes]];
        
        #ifdef DEBUG
            NSLog(@"AESHelper - Result - %@", decryptedString);
        #endif
        
        return decryptedString;
    }
    free(decryptedBytes);
    return nil;
}
@end
