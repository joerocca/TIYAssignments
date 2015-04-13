// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.m instead.

#import "_Venue.h"

const struct VenueAttributes VenueAttributes = {
	.cityStateZip = @"cityStateZip",
	.icon = @"icon",
	.name = @"name",
	.phoneNumber = @"phoneNumber",
	.rating = @"rating",
	.streetAddress = @"streetAddress",
	.venueDescription = @"venueDescription",
};

const struct VenueRelationships VenueRelationships = {
	.coordinates = @"coordinates",
};

@implementation VenueID
@end

@implementation _Venue

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Venue";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:moc_];
}

- (VenueID*)objectID {
	return (VenueID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic cityStateZip;

@dynamic icon;

@dynamic name;

@dynamic phoneNumber;

@dynamic rating;

- (int16_t)ratingValue {
	NSNumber *result = [self rating];
	return [result shortValue];
}

- (void)setRatingValue:(int16_t)value_ {
	[self setRating:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result shortValue];
}

- (void)setPrimitiveRatingValue:(int16_t)value_ {
	[self setPrimitiveRating:[NSNumber numberWithShort:value_]];
}

@dynamic streetAddress;

@dynamic venueDescription;

@dynamic coordinates;

@end

