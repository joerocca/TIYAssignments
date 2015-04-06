// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.m instead.

#import "_Venue.h"

const struct VenueAttributes VenueAttributes = {
	.city = @"city",
	.icon = @"icon",
	.name = @"name",
	.phoneNumber = @"phoneNumber",
	.postalCode = @"postalCode",
	.state = @"state",
	.streetAddress = @"streetAddress",
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

	if ([key isEqualToString:@"phoneNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"phoneNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"postalCodeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"postalCode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic city;

@dynamic icon;

@dynamic name;

@dynamic phoneNumber;

- (int32_t)phoneNumberValue {
	NSNumber *result = [self phoneNumber];
	return [result intValue];
}

- (void)setPhoneNumberValue:(int32_t)value_ {
	[self setPhoneNumber:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitivePhoneNumberValue {
	NSNumber *result = [self primitivePhoneNumber];
	return [result intValue];
}

- (void)setPrimitivePhoneNumberValue:(int32_t)value_ {
	[self setPrimitivePhoneNumber:[NSNumber numberWithInt:value_]];
}

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

@dynamic streetAddress;

@dynamic coordinates;

@end

