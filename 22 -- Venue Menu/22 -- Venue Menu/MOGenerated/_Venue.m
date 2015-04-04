// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.m instead.

#import "_Venue.h"

const struct VenueAttributes VenueAttributes = {
	.city = @"city",
	.name = @"name",
	.postalCode = @"postalCode",
	.state = @"state",
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

	if ([key isEqualToString:@"postalCodeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"postalCode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic city;

@dynamic name;

@dynamic postalCode;

- (int16_t)postalCodeValue {
	NSNumber *result = [self postalCode];
	return [result shortValue];
}

- (void)setPostalCodeValue:(int16_t)value_ {
	[self setPostalCode:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePostalCodeValue {
	NSNumber *result = [self primitivePostalCode];
	return [result shortValue];
}

- (void)setPrimitivePostalCodeValue:(int16_t)value_ {
	[self setPrimitivePostalCode:[NSNumber numberWithShort:value_]];
}

@dynamic state;

@dynamic coordinates;

@end

