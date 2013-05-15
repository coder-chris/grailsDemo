package grailsdemo

class City {
	static belongsTo  = [country: Country]
	String name
	
	
    static constraints = {
		name(blank: false, maxSize: 100)
    }
}
