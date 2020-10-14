//
//  NSString+JapaneseExtras.h
//
//  Created by Grace Steven on 3/26/11.
//  Copyright 2011 works5.com All rights reserved.
//
//https://github.com/00StevenG/NSString-Japanese



#import "NSString+Japanese.h"

#if TARGET_OS_IPHONE
#import <UIKit/UITextChecker.h>
#else

#endif





@implementation NSString (NSString_Japanese)

/*
 +    Character unicode memo
 +
 +    Hiragana:
 +        Hiragana: 3040-309F
 +
 +    Katakana:
 +        Katakana: 30A0-30FF (except 30FB: KATAKANA MIDDLE DOT)
 +        Halfwidth and Fullwidth Forms (FF00-FFEF): FF66-FF9F
 +        * Katakana Phonetic Extensions: 31F0-31FF
 +
 +    Kanji:
 +        CJK Radicals Supplement: 2E80-2EFF
 +        Kangxi Radicals: 2F00-2FDF
 +        CJK Unified Ideographs: 4E00-9FAF
 +        * Ideographic Description Characters: 2FF0-2FFF
 +        * CJK Unified Ideographs Extension A: 3400-4DBF
 +        * CJK Compatibility Ideographs: F900-FAFF
 +
 +    Kigou:
 +        * Arrows: 2190-21FF
 +        * Mathematical Operators: 2200-22FF
 +        * Box Drawing: 2500-257F
 +        * Geometric Shapes: 25A0-25FF
 +        * Miscellaneous Symbols: 2600-26FF
 +        * CJK Symbols and Punctuation (3000-303F): 3003-303F
 +        * Enclosed CJK Letters and Months: 3200-32FF
 +        * CJK Compatibility: 3300-33FF
 +        * CJK Compatibility Forms: FE30-FE4F
 +        * Halfwidth and Fullwidth Forms (FF00-FFEF): FF5F-FF60, FF62-FF63, FFE0-FFF6, FFE8-FFEE
 +        * and others?
 +
 +    Space:
 +        C0 Controls and Basic Latin (0000-007F): 0020
 +        CJK Symbols and Punctuation (3000-303F): 3000
 +
 +    Kuten:
 +        CJK Symbols and Punctuation (3000-303F): 3001
 +        Halfwidth and Fullwidth Forms (FF00-FFEF): FF0E, FF64
 +
 +    Touten:
 +        CJK Symbols and Punctuation (3000-303F): 3002
 +        Halfwidth and Fullwidth Forms (FF00-FFEF): FF0C, FF61
 +
 +    Fullwidth characters of latain:
 +        Halfwidth and Fullwidth Forms (FF00-FFEF): FF01-FF5E (correspond to 0021-007E)
 +
 +    Fullwidth numeral:
 +        Halfwidth and Fullwidth Forms (FF00-FFEF): FF10-FF19
 +
 +    see http://www.unicode.org/charts/
 +
 */


/*
 The folllowing code was extracted from:
 *
 * http://www.tjhsst.edu/~jcranmer/c-ccov-old/src/trunk/mailnews/extensions/bayesian-spam-filter/src/nsBayesianFilter.cpp.gcov.html
 *
 *
 *
 */


#pragma mark - UNICODE Ranges


#define IN_RANGE(x, low, high)  ((low<=(x))&&((x)<=high))
#define IS_JA_HIRAGANA(x)   IN_RANGE(x, 0x3040, 0x309F)
#define IS_JA_KATAKANA(x)   ((IN_RANGE(x, 0x30A0, 0x30FF)&&((x)!=0x30FB))||IN_RANGE(x, 0xFF66, 0xFF9F))
#define IS_JA_KANJI(x)      (IN_RANGE(x, 0x2E80, 0x2EFF)||IN_RANGE(x, 0x2F00, 0x2FDF)||IN_RANGE(x, 0x4E00, 0x9FAF))
#define IS_JA_KUTEN(x)      (((x)==0x3001)||((x)==0xFF64)||((x)==0xFF0E))
#define IS_JA_TOUTEN(x)     (((x)==0x3002)||((x)==0xFF61)||((x)==0xFF0C))
#define IS_JA_SPACE(x)      ((x)==0x3000)
#define IS_JA_FWLATAIN(x)   IN_RANGE(x, 0xFF01, 0xFF5E)
#define IS_JA_FWNUMERAL(x)	IN_RANGE(x, 0xFF10, 0xFF19)
#define IS_JAPANESE_SPECIFIC(x)	(IN_RANGE(x, 0x3040, 0x30FF)||IN_RANGE(x, 0xFF01, 0xFF9F))



#pragma mark - Char class Helpers
typedef enum {
	char_class_space,
	char_class_others,
	char_class_hiragana,
	char_class_katakana,
	char_class_kanji,
	char_class_kuten,
	char_class_touten,
	char_class_kigou,
	char_class_fwlatain,
	char_class_ascii,
}char_class;
//
// Returns the char_class for a given unicode char
char_class getCharClass(unichar c){


	if(IS_JA_HIRAGANA(c)){
		return char_class_hiragana;
	}else if(IS_JA_KATAKANA(c)){
		return char_class_katakana;
	}else if(IS_JA_KANJI(c)){
		return char_class_kanji;
	}else if(IS_JA_KUTEN(c)){
		return char_class_kuten;
	}else if(IS_JA_TOUTEN(c)){
		return char_class_touten;
	}else if(IS_JA_SPACE(c)){
		return char_class_space;
	}else if(IS_JA_FWLATAIN(c)){
		return char_class_fwlatain;
	}else{
		return char_class_others;
	}
}
#pragma mark - Public
//
//
//
+(SLGJapaneseStringType)japaneseStringTypeForString:(NSString*)string{

	SLGJapaneseStringType aType = SLGJapaneseStringTypeOther;

	char_class lastCharClass = char_class_others;

	// loop through the string char by char
	for(int i = 0; i<[string length];i++){

		unichar aChar = [string characterAtIndex:i];
		char_class aCharClass = getCharClass(aChar);

		// first char set the  type to a current type
		if(i==0){
			lastCharClass = aCharClass;
		}
		else{

			if(lastCharClass != aCharClass){

				if(aCharClass == char_class_katakana ||
				   aCharClass == char_class_hiragana ||
				   aCharClass == char_class_kanji)
					return SLGJapaneseStringTypeCompound;

				return SLGJapaneseStringTypeOther;

			}

		}

	}

	if(lastCharClass == char_class_hiragana){
		aType = SLGJapaneseStringTypeHiragana;
	}
	else if(lastCharClass == char_class_katakana){
		aType = SLGJapaneseStringTypeKatakana;
	}
	else if(lastCharClass == char_class_kanji){
		aType = SLGJapaneseStringTypeKanji;
	}

	return  aType;


}
//
//
//
+(BOOL)stringContainsJapaneseText:(NSString*)aString{

	for(int i = 0; i<[aString length];i++){

		BOOL isHiraganaOrKatakana =  IS_JAPANESE_SPECIFIC([aString characterAtIndex:i]);
		BOOL isKanji = IS_JA_KANJI([aString characterAtIndex:i]);

		if(isHiraganaOrKatakana == YES || isKanji == YES)
			return YES;

	}
	return NO;
}
#pragma mark - Japanese String Transiliteration
//
//
//
+(NSString*)_transliterateString:(NSString*)source
				   withTransform:(CFStringRef)aTransform{

	CFMutableStringRef mString = CFStringCreateMutableCopy(kCFAllocatorDefault,0,(CFStringRef)source);

	BOOL result = CFStringTransform(mString,NULL,aTransform,NO);

	if(result){
		NSString* resultString = [NSString stringWithFormat:@"%@",mString];
		CFRelease(mString);
		return resultString;
	}
	CFRelease(mString);
	return  nil;
}
//
//
//
-(NSString*)stringByTransliteratingJapaneseToRomajiWithWordSeperator:(NSString*)separator{

	NSMutableString* aLatinString = [[NSMutableString alloc]init];

	// create a tokenizer
	CFStringTokenizerRef tok = CFStringTokenizerCreate(NULL,
													   (CFStringRef)self,
													   CFRangeMake(0,self.length),
													   kCFStringTokenizerUnitWord,
													   NULL);
	// goto the first token in the string
	CFStringTokenizerTokenType result  =CFStringTokenizerAdvanceToNextToken(tok);

	// enumerate until the end
	while(result !=kCFStringTokenizerTokenNone){

		CFTypeRef cTypeRef =  CFStringTokenizerCopyCurrentTokenAttribute(tok,kCFStringTokenizerAttributeLatinTranscription);

		if(separator){
			[aLatinString appendFormat:@"%@%@",separator,cTypeRef];
		}
		else{
			[aLatinString appendFormat:@"%@",cTypeRef];
		}
		CFRelease(cTypeRef);

		result =CFStringTokenizerAdvanceToNextToken(tok);


	}

	CFRelease(tok);

	return [NSString stringWithString:aLatinString];
}
//
//
//
-(NSString*)stringByTransliteratingJapaneseToRomaji{

	return [self stringByTransliteratingJapaneseToRomajiWithWordSeperator:nil];

}
//
//
//
-(NSString*)stringByTransliteratingJapaneseToHiragana{


	NSString* romaji = [self stringByTransliteratingJapaneseToRomaji];

	return [NSString _transliterateString:romaji
							withTransform:kCFStringTransformLatinHiragana];
}
//
//
//
-(NSString*)stringByTransliteratingRomajiToKatakana{

	return [NSString _transliterateString:self
							withTransform:kCFStringTransformLatinKatakana];

}
//
//
//
-(NSString*)stringByTransliteratingRomajiToHiragana{

	return [NSString _transliterateString:self
							withTransform:kCFStringTransformLatinHiragana];

}
//
//
//
-(NSString*)stringByReplacingJapaneseKanjiWithHiragana{

	NSMutableString* kanjiFree = [[NSMutableString alloc]init];

	// create a tokenizer to enumerate by WORD
	NSLocale *locale= [[NSLocale alloc]initWithLocaleIdentifier:@"ja_JP"];
	CFLocaleRef loc=(__bridge CFLocaleRef)(locale);

	CFStringTokenizerRef tok = CFStringTokenizerCreate(NULL,
													   (CFStringRef)self,
													   CFRangeMake(0,self.length),
													   kCFStringTokenizerUnitWordBoundary,
													   loc);
	// goto the first token in the string
	CFStringTokenizerTokenType result  =CFStringTokenizerAdvanceToNextToken(tok);

	// enumerate the string
	while(result !=kCFStringTokenizerTokenNone){

		CFRange currentRange = CFStringTokenizerGetCurrentTokenRange(tok);
		NSString* subString = [self substringWithRange:NSMakeRange(currentRange.location, currentRange.length)];

		// check the type of the substring
		SLGJapaneseStringType type = [[self class]japaneseStringTypeForString:subString];


		// for kanji or strings with a combination(kanij+hiragana) of characters convert to hirgana
		if(type == SLGJapaneseStringTypeKanji || type == SLGJapaneseStringTypeCompound){
			NSString* hiragana = [subString stringByTransliteratingJapaneseToHiragana];
			[kanjiFree appendFormat:@"%@",hiragana];
		}
		else{
			// othewise just append the substring as is
			[kanjiFree appendFormat:@"%@",subString];
		}

		result =CFStringTokenizerAdvanceToNextToken(tok);
	}

	CFRelease(tok);

	return [kanjiFree copy];


}

-(NSString*)stringByFormatFurigana {
	NSMutableArray *replaceObjects = [NSMutableArray array];

	// create a tokenizer to enumerate by WORD
	NSLocale *locale= [[NSLocale alloc]initWithLocaleIdentifier:@"ja_JP"];
	CFLocaleRef loc=(__bridge CFLocaleRef)(locale);

	CFStringTokenizerRef tok = CFStringTokenizerCreate(NULL,
													   (CFStringRef)self,
													   CFRangeMake(0,self.length),
													   kCFStringTokenizerUnitWordBoundary,
													   loc);
	// goto the first token in the string
	CFStringTokenizerTokenType result  =CFStringTokenizerAdvanceToNextToken(tok);

	// enumerate the string
	while(result !=kCFStringTokenizerTokenNone) {
		CFRange currentRange = CFStringTokenizerGetCurrentTokenRange(tok);
		NSString* subString = [self substringWithRange:NSMakeRange(currentRange.location, currentRange.length)];

		BOOL isContainsKanji =  [subString stringContainsKanjiText];

		// check the type of the substring
		SLGJapaneseStringType type = [[self class]japaneseStringTypeForString:subString];

		// for kanji or strings with a combination(kanij+hiragana) of characters convert to hirgana
		if ((type == SLGJapaneseStringTypeKanji || type == SLGJapaneseStringTypeCompound) && (isContainsKanji == YES)) {
			CFTypeRef cTypeRef = CFStringTokenizerCopyCurrentTokenAttribute(tok,kCFStringTokenizerAttributeLatinTranscription);
			NSString *latin = [NSString stringWithFormat:@"%@",cTypeRef];
			NSString *hiragana = [NSString _transliterateString:latin withTransform:kCFStringTransformLatinHiragana];

			int maxCount = (int)MIN([hiragana length], [subString length]);
			int locationModify = 0;
			int lengthModify = 0;

			// for let to right
			for (int i = 0; i < maxCount; i++) {
				NSString *str1 = [subString substringWithRange:NSMakeRange(i, 1)];
				NSString *str2 = [hiragana substringWithRange:NSMakeRange(i, 1)];

				if ([str1 isEqualToString: str2]) {
					locationModify += 1;
				} else {
					break;
				}
			}

			// for right to left
			for (int i = 0; i < maxCount; i++) {
				NSString *str1 = [subString substringWithRange:NSMakeRange([subString length] - (i + 1), 1)];
				NSString *str2 = [hiragana substringWithRange:NSMakeRange([hiragana length] - (i + 1), 1)];

				if ([str1 isEqualToString:str2]) {
					lengthModify += 1;
				} else {
					break;
				}
			}
			NSString *subString2 = [subString substringWithRange: NSMakeRange(locationModify, [subString length] - lengthModify - locationModify)];
			NSRange subRange = NSMakeRange(locationModify, [hiragana length] - locationModify - lengthModify);
			NSString *modifyHiragana = [hiragana substringWithRange: subRange];
			NSRange range= NSMakeRange(currentRange.location + locationModify, currentRange.length - locationModify - lengthModify);
			NSString *replaceHiragana;

			// loop through the string char by char
			NSUInteger startIndexHiragana = 0;
			NSUInteger startIndexKanji = 0;
			NSString *formatMidString = @"";
			NSString *remainKanji = @"";
			NSString *remainHiragana = @"";

			for(int i = 0; i < [subString2 length]; i++) {
				BOOL isKanji = IS_JA_KANJI([subString2 characterAtIndex:i]);

				if (!isKanji) {
					NSString *str = [NSString  stringWithFormat:@"%C", [subString2 characterAtIndex:i]];
					NSRange fRange = [modifyHiragana rangeOfString:str];

					if (fRange.location != NSNotFound) {
						NSString *kanji1 = [subString2 substringWithRange:NSMakeRange(startIndexKanji, i)];
						NSString *hiragana1 = [modifyHiragana substringWithRange: NSMakeRange(startIndexHiragana, fRange.location)];

						formatMidString = [NSString stringWithFormat:@"%@｜%@＜%@＞%@", formatMidString, kanji1, hiragana1, str];

						startIndexKanji = i;
						startIndexHiragana = fRange.location;

						remainKanji = [subString2 substringWithRange:NSMakeRange(i+1, [subString2 length] - (i + 1))];
						remainHiragana = [modifyHiragana substringWithRange:NSMakeRange(fRange.location + 1, [modifyHiragana length] - (fRange.location + 1))];
					}
				}

				if ((i == [subString2 length] - 1) && ([remainKanji length]) > 0) {
					formatMidString = [NSString stringWithFormat:@"%@｜%@＜%@＞", formatMidString, remainKanji, remainHiragana];
				}
			}

			if ([formatMidString length] > 0) {
				replaceHiragana = formatMidString;
			} else {
				replaceHiragana = [NSString stringWithFormat:@"｜%@＜%@＞", subString2, modifyHiragana];
			}

			NSMutableDictionary *dict = [NSMutableDictionary dictionary];
			[dict setObject:replaceHiragana forKey: [NSValue valueWithRange:range]];

			[replaceObjects addObject:dict];
		}

		result = CFStringTokenizerAdvanceToNextToken(tok);
	}

	CFRelease(tok);

	NSString *replaceString = self;

	if (replaceObjects.count > 0) {
		for (int i = (int)[replaceObjects count] - 1; i >= 0; i--) {
			NSDictionary *dic = [replaceObjects objectAtIndex:i];

			for (NSValue *value in dic.keyEnumerator) {
				NSRange range = value.rangeValue;
				NSString *string = [dic objectForKey:value];

				replaceString = [replaceString stringByReplacingCharactersInRange:range withString:string];
			}
		}
	}

	return replaceString;
}

-(BOOL)stringContainsKanjiText {
	for(int i = 0; i<[self length];i++){

		BOOL isKanji = IS_JA_KANJI([self characterAtIndex:i]);

		if(isKanji == YES)
			return YES;
	}

	return NO;
}

-(NSDictionary*)hiraganaReplacementsForString{

	NSMutableDictionary *dict=[NSMutableDictionary dictionary];

	// create a tokenizer to enumerate by WORD
	NSLocale *locale= [[NSLocale alloc]initWithLocaleIdentifier:@"ja_JP"];
	CFLocaleRef loc=(__bridge CFLocaleRef)(locale);

	CFStringTokenizerRef tok = CFStringTokenizerCreate(NULL,
													   (CFStringRef)self,
													   CFRangeMake(0,self.length),
													   kCFStringTokenizerUnitWordBoundary,
													   loc);
	// goto the first token in the string
	CFStringTokenizerTokenType result  =CFStringTokenizerAdvanceToNextToken(tok);

	// enumerate the string
	while(result !=kCFStringTokenizerTokenNone){

		CFRange currentRange = CFStringTokenizerGetCurrentTokenRange(tok);
		NSString* subString = [self substringWithRange:NSMakeRange(currentRange.location, currentRange.length)];

		// check the type of the substring
		SLGJapaneseStringType type = [[self class]japaneseStringTypeForString:subString];


		// for kanji or strings with a combination(kanij+hiragana) of characters convert to hirgana
		if(type == SLGJapaneseStringTypeKanji || type == SLGJapaneseStringTypeCompound){
			CFTypeRef cTypeRef =  CFStringTokenizerCopyCurrentTokenAttribute(tok,kCFStringTokenizerAttributeLatinTranscription);
			NSString *latin=[NSString stringWithFormat:@"%@",cTypeRef];
			NSString *hiragana=[NSString _transliterateString:latin withTransform:kCFStringTransformLatinHiragana];

			int maxCount = (int)MIN([hiragana length], [subString length]);
			int locationModify = 0;
			int lengthModify = 0;

			// for let to right
			for (int i = 0; i < maxCount; i++) {
				unichar str1 = [subString characterAtIndex:i];
				unichar str2 = [hiragana characterAtIndex:i];

				if (str1 == str2) {
					locationModify += 1;
				} else {
					break;
				}
			}

			// for right to left
			for (int i = 0; i < maxCount; i++) {
				NSString *str1 = [NSString stringWithFormat:@"%c", [subString characterAtIndex: [subString length] - (i + 1)]];
				NSString *str2 = [NSString stringWithFormat:@"%c", [hiragana characterAtIndex: [hiragana length] - (i + 1)]];

				if (str1 == str2) {
					lengthModify += 1;
				} else {
					break;
				}
			}

			//   NSString* hiragana = [subString stringByTransliteratingJapaneseToHiragana];
			NSRange subRange = NSMakeRange(locationModify, [hiragana length] - locationModify - lengthModify);
			NSString *modifyHiragana = [hiragana substringWithRange: subRange];
			NSRange range= NSMakeRange(currentRange.location + locationModify, currentRange.length - locationModify - lengthModify);
			[dict setObject:modifyHiragana forKey:[NSValue valueWithRange:range]];
			CFRelease(cTypeRef);
		}
		else{

		}

		result =CFStringTokenizerAdvanceToNextToken(tok);
	}

	CFRelease(tok);

	return [dict copy];


}



-(NSDictionary*)romajiReplacementsForString{

	NSMutableDictionary *dict=[NSMutableDictionary dictionary];

	// create a tokenizer to enumerate by WORD
	NSLocale *locale= [[NSLocale alloc]initWithLocaleIdentifier:@"ja_JP"];
	CFLocaleRef loc=(__bridge CFLocaleRef)(locale);

	CFStringTokenizerRef tok = CFStringTokenizerCreate(NULL,
													   (CFStringRef)self,
													   CFRangeMake(0,self.length),
													   kCFStringTokenizerUnitWordBoundary,
													   loc);
	// goto the first token in the string
	CFStringTokenizerTokenType result  =CFStringTokenizerAdvanceToNextToken(tok);

	// enumerate the string
	while(result !=kCFStringTokenizerTokenNone){

		CFRange currentRange = CFStringTokenizerGetCurrentTokenRange(tok);
		NSString* subString = [self substringWithRange:NSMakeRange(currentRange.location, currentRange.length)];

		// check the type of the substring
		SLGJapaneseStringType type = [[self class]japaneseStringTypeForString:subString];


		// for kanji or strings with a combination(kanij+hiragana) of characters convert to hirgana
		if(type == SLGJapaneseStringTypeKanji || type == SLGJapaneseStringTypeCompound || type==SLGJapaneseStringTypeKatakana || type==SLGJapaneseStringTypeHiragana){
			CFTypeRef cTypeRef =  CFStringTokenizerCopyCurrentTokenAttribute(tok,kCFStringTokenizerAttributeLatinTranscription);
			NSString *latin=[NSString stringWithFormat:@"%@",cTypeRef];
			NSRange range=NSMakeRange(currentRange.location, currentRange.length);
			[dict setObject:latin forKey:[NSValue valueWithRange:range]];
			CFRelease(cTypeRef);
		}
		else{

		}

		result =CFStringTokenizerAdvanceToNextToken(tok);
	}

	CFRelease(tok);

	return [dict copy];


}








#pragma mark - Phonetic Methods
//
//
//
-(CGFloat)phoneticSimilarityToString:(NSString*)string{

	return [self phoneticSimilarityToString:string isLatinScript:NO];
}
//
//
//
-(CGFloat)phoneticSimilarityToString:(NSString*)string isLatinScript:(BOOL)isLatinScript{


	NSString* sourceString= self;

	if(isLatinScript==NO)
		sourceString = [self stringByTransliteratingJapaneseToHiragana];


	__block NSMutableSet* sourceSet = [[NSMutableSet alloc]init];

	[sourceString enumerateSubstringsInRange:NSMakeRange(0,[sourceString length])
									 options:NSStringEnumerationByComposedCharacterSequences
								  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

		if(isLatinScript==NO){
			[sourceSet addObject:[substring stringByTransliteratingJapaneseToRomaji]];
		}
		else{
			[sourceSet addObject:substring];
		}

	}];



	NSString* targetString = string;

	if(isLatinScript==NO)
		[string stringByTransliteratingJapaneseToHiragana];

	__block NSMutableSet* targetSet = [[NSMutableSet alloc]init];

	[targetString enumerateSubstringsInRange:NSMakeRange(0,[targetString length])
									 options:NSStringEnumerationByComposedCharacterSequences
								  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

		if(isLatinScript==NO){
			[targetSet addObject:[substring stringByTransliteratingJapaneseToRomaji]];
		}
		else{
			[targetSet addObject:substring];
		}

	}];

	CGFloat sourceTotal = [sourceSet count];
	CGFloat targetTotal = [targetSet count];

	CGFloat lengthRatio = fabs(sourceTotal-targetTotal)/(MAX(sourceTotal,targetTotal));


	// remove the source sounds from the target
	// the result are the  target sounds not contained in the source
	[targetSet minusSet:sourceSet];
	CGFloat adjustedCount = [targetSet count];


	return (1- (adjustedCount/targetTotal)*(1-lengthRatio));

}

- (NSDictionary *)JSONFromFile:(NSString*)fileName
{
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)doSomethingWithTheJson
{
	NSDictionary *dict = [self JSONFromFile:@""];

	NSArray *colours = [dict objectForKey:@"colors"];

	for (NSDictionary *colour in colours) {
		NSString *name = [colour objectForKey:@"name"];
		NSLog(@"Colour name: %@", name);

		if ([name isEqualToString:@"green"]) {
			NSArray *pictures = [colour objectForKey:@"pictures"];
			for (NSDictionary *picture in pictures) {
				NSString *pictureName = [picture objectForKey:@"name"];
				NSLog(@"Picture name: %@", pictureName);
			}
		}
	}
}


@end
