package grailsDemo

class Country {
	static hasMany = [cities: City]
	String name
	String iso2digitCode
	String iso3digitCode
	
    static constraints = {
		name(blank: false, maxSize: 100)
		iso2digitCode(blank: false, maxSize:2)
		iso3digitCode(blank: false, maxSize:3)
	}
	
}
