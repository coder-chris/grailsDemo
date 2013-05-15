package grailsDemo

class City {

	String name
	static belongsTo  = [country: Country]
	
    static constraints = {
		name(blank: false, maxSize: 100)
    }
}
