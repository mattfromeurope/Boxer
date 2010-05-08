/* 
 Boxer is copyright 2009 Alun Bestor and contributors.
 Boxer is released under the GNU General Public License 2.0. A full copy of this license can be
 found in this XCode project at Resources/English.lproj/GNU General Public License.txt, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */


#import "BXEmulator+BXPaste.h"

@implementation BXEmulator (BXPaste)

- (BOOL) handlePastedString: (NSString *)pastedString
{
	if ([self isAtPrompt])
	{
		//Split string into separate lines, which will be pasted one by one as commands
		NSArray *lines = [pastedString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
		NSUInteger i, numLines = [lines count];
		for (i = 0; i < numLines; i++)
		{
			//Remove whitespace from each line
			NSString *cleanedString = [[lines objectAtIndex: i]
									   stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
			
			if ([cleanedString length])
			{
				//Execute each line immediately, except for the last one, which we leave in case the user wants to modify it
				if (i < numLines - 1) cleanedString = [cleanedString stringByAppendingString: @"\n"]; 
				[[self commandQueue] addObject: cleanedString];
			}
		}
		return YES;
	}
	return NO;
}

- (BOOL) canAcceptPastedString: (NSString *)pastedString
{
	//Disabled-for-1.0: Disable paste and drag-drop of text for now, as there are too many bugs for it to be a releasable feature.
	return NO;
	//return [self isAtPrompt];
}

@end