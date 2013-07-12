//
//  HuesColorTest.m
//  Hues
//
//  Created by Zach Waugh on 5/30/11.
//  Copyright 2011 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSColor+Hues.h"
#import "HuesPreferences.h"

@interface HuesColorTest : SenTestCase

- (void)testConvertedColor;
- (void)testIsDark;
- (void)testRelativeBrightness;

//- (void)testHexFromColor;
//- (void)testHexFormatParsing;
//
//- (void)testRGBFromColor;
//- (void)testHSLFromColor;
//- (void)testLowerCasePreference;
//
//- (void)testNSColorCalibratedRGB;
//- (void)testNSColorDeviceRGB;
//- (void)testUIColorRGB;
//- (void)testUIColorHSB;

@end

@implementation HuesColorTest

- (void)setUp
{
  [super setUp];
  [HuesPreferences registerDefaults];
}

- (void)tearDown
{
  // Tear-down code here.
  [super tearDown];
}

- (void)testConvertedColor
{
	NSColor *color = [NSColor whiteColor];
	expect([color hues_convertedColor]).toNot.equal(color);
	
	color = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	expect([color hues_convertedColor]).to.equal(color);
	
	color = [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	expect([color hues_convertedColor]).to.equal(color);
}

- (void)testIsDark
{
	expect([[NSColor whiteColor] hues_isColorDark]).to.beFalsy();
	expect([[NSColor blackColor] hues_isColorDark]).to.beTruthy();
	expect([[NSColor colorWithCalibratedRed:1.0 green:0.0 blue:0.0 alpha:1.0] hues_isColorDark]).to.beTruthy();
	expect([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1.0] hues_isColorDark]).to.beFalsy();
}

- (void)testRelativeBrightness
{
	expect([[NSColor whiteColor] hues_relativeBrightness]).to.equal(255);
	expect([[NSColor colorWithCalibratedRed:1.0 green:0.0 blue:0.0 alpha:1.0] hues_relativeBrightness]).to.equal(125);
	expect([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1.0] hues_relativeBrightness]).to.equal(128);
	expect([[NSColor blackColor] hues_relativeBrightness]).to.equal(0);
}

//- (void)testLowerCasePreference
//{
//  BOOL useLowercase = [HuesPreferences useLowercase];
//  
//  STAssertFalse(useLowercase, @"Not lowercase by default");
//  STAssertEqualObjects([[NSColor whiteColor] hues_hex], @"#FFFFFF", @"default should be uppercase");
//  
//  [HuesPreferences setUseLowercase:YES];
//  useLowercase = [HuesPreferences useLowercase];
//  
//  STAssertTrue(useLowercase, @"Not lowercase by default");
//  STAssertEqualObjects([[NSColor whiteColor] hues_hex], @"#ffffff", @"default should be uppercase");
//}
//
//- (void)testHexFromColor
//{
//  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:YES], @"#ffffff", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_hexWithLowercase:NO], @"#000000", @"");
//  
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_hexWithLowercase:NO], @"#000000", @"");
//  
//  
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
//}
//
//- (void)testRGBFromColor
//{
//  // test basic black and white
//  STAssertEqualObjects([[NSColor whiteColor] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  
//  // test rgba is correctly returned
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.00)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.00)", @"");
//  
//  // test various values - rgb
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
//}
//
//- (void)testHSLFromColor
//{
//  // test basic black and white
//  STAssertEqualObjects([[NSColor whiteColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 100%)", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 0%)", @"");
//  
//  // test various colors
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(0, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:1 alpha:1] hues_hslWithDefaultFormat], @"hsl(300, 100%, 50%)", @"");
//  
//  // test hsla is returned
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 100%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 0%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:0.75] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.75)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.25] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:0.1] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.10)", @"");
//}
//
//- (void)testHexFormatParsing
//{
//  NSColor *color = [NSColor whiteColor];
//  
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}" useLowercase:YES], @"ff", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}" useLowercase:YES], @"ffffff", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF FF FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-FF-FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_FF_FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{FF}{FF}", @"");
//  
//  color = [NSColor colorWithCalibratedRed:1 green:0.5 blue:0.25 alpha:1];
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"80", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF 80 40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-80-40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_80_40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{80}{40}", @"");
//}
//
//- (void)testNSColorCalibratedRGB
//{
//	// Test full white and full black
//	expect([[NSColor whiteColor] hues_NSColorCalibratedRGB]).to.equal(@"[NSColor colorWithCalibratedRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
//  expect([[NSColor blackColor] hues_NSColorCalibratedRGB]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor redColor] hues_NSColorCalibratedRGB]).to.equal(@"[NSColor colorWithCalibratedRed:1.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor blueColor] hues_NSColorCalibratedRGB]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:0.000 blue:1.000 alpha:1.000]");
//	expect([[NSColor greenColor] hues_NSColorCalibratedRGB]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
//}
//
//- (void)testNSColorDeviceRGB
//{
//	// Test full white and full black
//	expect([[NSColor whiteColor] hues_NSColorDeviceRGB]).to.equal(@"[NSColor colorWithDeviceRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
//  expect([[NSColor blackColor] hues_NSColorDeviceRGB]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor redColor] hues_NSColorDeviceRGB]).to.equal(@"[NSColor colorWithDeviceRed:1.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor blueColor] hues_NSColorDeviceRGB]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:0.000 blue:1.000 alpha:1.000]");
//}
//
//- (void)testUIColorRGB
//{
//	// Test full white/black/red/blue/green
//	expect([[NSColor whiteColor] hues_UIColorRGB]).to.equal(@"[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
//  expect([[NSColor blackColor] hues_UIColorRGB]).to.equal(@"[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor redColor] hues_UIColorRGB]).to.equal(@"[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]");
//	expect([[NSColor blueColor] hues_UIColorRGB]).to.equal(@"[UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:1.000]");
//	expect([[NSColor greenColor] hues_UIColorRGB]).to.equal(@"[UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
//}
//
//- (void)testUIColorHSB
//{
//	// Test full white/black/red/blue/green
//	STAssertEqualObjects([[NSColor whiteColor] hues_UIColorHSB], @"[UIColor colorWithHue:1.000 saturation:1.000 brightness:1.000 alpha:1.000]", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_UIColorHSB], @"[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]", @"");
//	STAssertEqualObjects([[NSColor redColor] hues_UIColorHSB], @"[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:1.000]", @"");
//	STAssertEqualObjects([[NSColor blueColor] hues_UIColorHSB], @"[UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:1.000]", @"");
//	STAssertEqualObjects([[NSColor greenColor] hues_UIColorHSB], @"[UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000]", @"");
//}

@end
